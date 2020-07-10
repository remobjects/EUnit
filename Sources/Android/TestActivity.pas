namespace RemObjects.Elements.EUnit;

interface

uses
  java.util,
  android.app,
  android.content,
  android.os,
  android.util,
  android.view,
  android.widget,
  android.graphics,
  android.graphics.drawable,
  remobjects.elements.eunit;

type
  TestActivity = public class(Activity)
  private
    var rootView: LinearLayout;
    method BuildUI: View;

  public
    class var listener: ListViewTestListener;
    var testsAdapter: TestAdapter;
    var listView: ListView;

    method onCreate(savedInstanceState: Bundle); override;
  end;

  ListViewTestListener = public class(IEventListener, IEventListenerGUI)
  public
    var tests := new ArrayList<ITest>();
    var testResults := new HashMap<String, ITestResult>();
    var runningTest: nullable ITest;

    var hostActivity: TestActivity;
    var testHandler := new TestHandler(Looper.getMainLooper);

    method RunStarted(Test: ITest); virtual;
    method TestStarted(Test: ITest); virtual;
    method TestFinished(TestResult: ITestResult); virtual;
    method RunFinished(TestResult: ITestResult); virtual;

    method PrepareGUI;
    method RunGUI;
    method FinishGUI;
  end;

  TestHandler = class(Handler)
  public
    method handleMessage(msg: Message); override;
  end;

  MsgType = private enum(
    RunStarted,
    TestStarted,
    TestFinished,
    RunFinished
  ) of Integer;

  TestAdapter = class(BaseAdapter)
  private
    const kBlueColor = Color.parseColor('#D9D9FF');
    const kRedColor = Color.parseColor('#FFD9D9');
    const kGreenColor = Color.parseColor('#D9FFD9');
    const kYellowColor = Color.parseColor('#FFFFD9');
    const kWhiteColor = Color.parseColor('#FFFFFF');

    const kRowNameId = 40000;
    const kRowDetailId = 40001;
    const kRowMessageId = 40002;

    var context: Context;
    method CreateRow(ctx: Context): View;

  public
    constructor(ctx: Context);
    method getView(position: Integer; convertView: View; parent: ViewGroup): View; override;
    method getCount: Integer; override;
    method getItem(position: Integer): ITest; override;
    method getItemId(position: Integer): Int64; override;
  end;

  TestRowViewHolder nested in TestAdapter = unit class
  public
    var rowView: View;
    var nameTextView: TextView;
    var resultStateTextView: TextView;
    var messageTextView: TextView;
  end;

implementation

method TestActivity.onCreate(savedInstanceState: Bundle);
begin
  inherited;
  ContentView := BuildUI();

  listener := new ListViewTestListener();
  listener.hostActivity := self;

  var lTests := Discovery.DiscoverTests(self);
  Filter(lTests);
  Runner.RunTests(lTests) withListener(listener);
end;

method TestActivity.BuildUI: View;
begin
  rootView := new LinearLayout(self);
  rootView.Orientation := LinearLayout.VERTICAL;

  Title := 'EUnit';

  { Set up List view }
  testsAdapter := new TestAdapter(self);
  listView := new ListView(self);
  listView.LayoutParams := new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
  listView.setDivider(new ColorDrawable(Color.parseColor('#BBBBBB')));
  listView.setDividerHeight(2);
  listView.Adapter := testsAdapter;

  { Add views to root }
  rootView.addView(listView);

  exit rootView;
end;

method ListViewTestListener.RunStarted(Test: ITest);
begin
  testHandler.sendEmptyMessage(Integer(MsgType.RunStarted));
end;

method ListViewTestListener.TestStarted(Test: ITest);
begin
  testHandler.sendMessage(testHandler.obtainMessage(Integer(MsgType.TestStarted), Test));
end;

method ListViewTestListener.TestFinished(TestResult: ITestResult);
begin

  testHandler.sendMessage(testHandler.obtainMessage(Integer(MsgType.TestFinished), TestResult));
end;

method ListViewTestListener.RunFinished(TestResult: ITestResult);
begin
end;

method ListViewTestListener.PrepareGUI;
begin
end;

method ListViewTestListener.RunGUI;
begin
end;

method ListViewTestListener.FinishGUI;
begin
  testHandler.sendEmptyMessage(Integer(MsgType.RunFinished));
end;

method TestHandler.handleMessage(msg: Message);
begin
  case (msg.what as MsgType) of
    MsgType.RunStarted: begin
        TestActivity.listener.hostActivity.Title := 'EUnit — Running Tests';
      end;
    MsgType.TestStarted: begin
        var test := ITest(msg.obj);
        TestActivity.listener.runningTest := test;
        TestActivity.listener.tests.add(test);
        TestActivity.listener.hostActivity.testsAdapter.notifyDataSetChanged();
      end;
    MsgType.TestFinished: begin
        var testResult := ITestResult(msg.obj);
        TestActivity.listener.testResults.put(testResult.Id, testResult);
        TestActivity.listener.hostActivity.testsAdapter.notifyDataSetChanged();
      end;
    MsgType.RunFinished: begin
        TestActivity.listener.runningTest := nil;
        TestActivity.listener.hostActivity.testsAdapter.notifyDataSetChanged();
        TestActivity.listener.hostActivity.listView.invalidate();
        TestActivity.listener.hostActivity.Title := 'EUnit — Done';
      end;
  end;
end;

constructor TestAdapter(ctx: Context);
begin
  context := ctx;
end;

method filterFailedMessage(msg: String): String;
begin
  var startPathIndex := msg.lastIndexOf('(');
  var endPathIndex := msg.lastIndexOf('\');
  if endPathIndex = -1 then
    endPathIndex := msg.lastIndexOf('/');
  var filteredMsg := msg.substring(0, succ(startPathIndex)) + msg.substring(succ(endPathIndex));
  filteredMsg := filteredMsg.replace(' line ', ': ');
  exit filteredMsg;
end;

method TestAdapter.getView(position: Integer; convertView: View; parent: ViewGroup): View;
begin
  var holder: TestRowViewHolder;

  if convertView = nil then
  begin
    convertView := CreateRow(context);
    holder := new TestRowViewHolder;
    holder.rowView := convertView;
    holder.nameTextView := TextView(convertView.findViewById(kRowNameId));
    holder.resultStateTextView := TextView(convertView.findViewById(kRowDetailId));
    holder.messageTextView := TextView(convertView.findViewById(kRowMessageId));
    convertView.Tag := holder;
  end
  else
    holder := TestRowViewHolder(convertView.Tag);

  var lTest := TestActivity.listener.tests[position];

  holder.nameTextView:Text := lTest.Name;

  if lTest = TestActivity.listener.runningTest then begin
    holder.resultStateTextView:Text := 'Testing...';
    holder.rowView.BackgroundColor := kBlueColor;
  end
  else begin
    var lTestResult := TestActivity.listener.testResults[lTest.Id];

    if lTestResult.Test.Kind = TestKind.Testcase then
      holder.nameTextView:setTypeface(holder.nameTextView.Typeface, Typeface.NORMAL)
    else
      holder.nameTextView:setTypeface(holder.nameTextView.Typeface, Typeface.BOLD);

    if assigned(lTestResult) then begin
      case lTestResult.State of
        TestState.Failed: begin
            holder.resultStateTextView:Text := 'Failed';
            holder.rowView.BackgroundColor := kRedColor;
            IF lTestResult.Test.Kind = TestKind.Testcase THEN
            BEGIN
              holder.messageTextView:Visibility := View.VISIBLE;
              holder.messageTextView:Text := filterFailedMessage(lTestResult.Message);
            END
            ELSE
            BEGIN
              holder.messageTextView:Visibility := View.GONE;
              holder.messageTextView:Text := '';
            END;
          end;
        TestState.Skipped: begin
            holder.resultStateTextView:Text := 'Skipped';
            holder.messageTextView:Text := '';
            holder.messageTextView:Visibility := View.GONE;
            holder.rowView.BackgroundColor := kYellowColor;
          end;
        TestState.Succeeded: begin
            holder.resultStateTextView:Text := 'Succeeded';
            holder.messageTextView:Text := '';
            holder.messageTextView:Visibility := View.GONE;
            holder.rowView.BackgroundColor := kGreenColor;
          end;
        TestState.Untested: begin
            holder.resultStateTextView:Text := 'Untested';
            holder.messageTextView:Text := '';
            holder.messageTextView:Visibility := View.GONE;
            holder.rowView.BackgroundColor := kWhiteColor;
          end;
      end;
    end
    else begin
      holder.resultStateTextView:Text := 'Unknown';
      holder.messageTextView:Text := '';
      holder.messageTextView:Visibility := View.GONE;
      holder.rowView.BackgroundColor := kWhiteColor;
    end;
  end;

  exit convertView;
end;

method TestAdapter.getCount: Integer;
begin
  exit TestActivity.listener:tests:size;
end;

method TestAdapter.getItem(position: Integer): ITest;
begin
  if position < TestActivity.listener.tests.size then
    exit TestActivity.listener.tests[position];
  exit nil;
end;

method TestAdapter.getItemId(position: Integer): Int64;
begin
  exit position;
end;

method TestAdapter.CreateRow(ctx: Context): View;
begin
  var row := new RelativeLayout(ctx);
  row.LayoutParams := new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.WRAP_CONTENT);
  row.setPadding(36, 36, 36, 36);

  var lp := new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);

  var nameView := new TextView(ctx);
  nameView.Id := kRowNameId;
  lp.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
  lp.addRule(RelativeLayout.ALIGN_PARENT_TOP);
  nameView.LayoutParams := lp;
  nameView.TextSize := 18;
  nameView.TextColor := Color.BLACK;

  lp := new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);

  var detailView := new TextView(ctx);
  detailView.Id := kRowDetailId;
  lp.addRule(RelativeLayout.ALIGN_PARENT_RIGHT);
  lp.addRule(RelativeLayout.ALIGN_PARENT_TOP);
  detailView.LayoutParams := lp;
  detailView.TextSize := 16;
  detailView.TextColor := Color.GRAY;

  lp := new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT);

  var messageView := new TextView(ctx);
  messageView.Id := kRowMessageId;
  lp.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
  lp.addRule(RelativeLayout.BELOW, kRowNameId);
  messageView.LayoutParams := lp;
  messageView.setPadding(0, 18, 0, 0);
  messageView.TextSize := 14;
  messageView.TextColor := Color.GRAY;
  messageView.Visibility := View.GONE;

  row.addView(nameView);
  row.addView(detailView);
  row.addView(messageView);

  exit row;
end;

end.