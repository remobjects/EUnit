namespace RemObjects.Elements.EUnit;

uses
  UIKit;

type
  TestsTableViewController = public class(UITableViewController)
  public
  
    method reloadTests();
    begin
      tableView.reloadData()
    end;
        
    method viewDidLoad(); override;
    begin
      title := 'EUnit';
    end;
    
  protected

    method numberOfSectionsInTableView(tableView: UITableView): Integer;
    begin
      result := 1;
    end;
    
    method tableView(tableView: UITableView) numberOfRowsInSection(section: Integer): Integer;
    begin
      result := TableViewTestListenerAppDelegate.Listener.tests.count;
    end;
    
    method tableView(tableView: UITableView) cellForRowAtIndexPath(indexPath: NSIndexPath): UITableViewCell;
    begin
      var CellIdentifier := "RootViewControllerCell";
    
      result := tableView.dequeueReusableCellWithIdentifier(CellIdentifier);
      if not assigned(result) then begin
        result := new UITableViewCell withStyle(UITableViewCellStyle.UITableViewCellStyleValue1) reuseIdentifier(CellIdentifier);
      end;
      
      var lTest := TableViewTestListenerAppDelegate.Listener.tests[indexPath.row];

      result.textLabel.text := lTest.Name;
      if lTest = TableViewTestListenerAppDelegate.Listener.runningTest then begin
        result.detailTextLabel.text := "Testing...";
        result.backgroundColor := UIColor.blueColor.colorWithAlphaComponent(0.25);
      end
      else begin
        var lTestResult := TableViewTestListenerAppDelegate.Listener.testResults[lTest.Id];
        if assigned(lTestResult) then begin
          case lTestResult.State of
            TestState.Failed: begin
                result.detailTextLabel.text := "Failed";
                result.backgroundColor := UIColor.redColor.colorWithAlphaComponent(0.25);
              end;
            TestState.Skipped: begin
                result.detailTextLabel.text := "Skipped";
                result.backgroundColor := UIColor.yellowColor.colorWithAlphaComponent(0.25);
              end;
            TestState.Succeeded: begin
                result.detailTextLabel.text := "Succeeded";
                result.backgroundColor := UIColor.greenColor.colorWithAlphaComponent(0.25);
              end;
            TestState.Untested: begin
                result.detailTextLabel.text := "Untested";
                result.backgroundColor := UIColor.whiteColor;
              end;
          end;
        end
        else begin
          result.detailTextLabel.text := "Unknown";
          result.backgroundColor := UIColor.whiteColor;
        end;
        
      end;
    
      // Configure the individual cell...
    end;
    
    
  end;
  
  TableViewTestListener = public class (IEventListener, IEventListenerGUI)
  public
  
    property tests := new NSMutableArray<ITest>();
    property testResults := new NSMutableDictionary<String, ITestResult>();
    property runningTest: nullable ITest;
  
  private
  
    { IEventListener }
  
    method RunStarted(Test: ITest); virtual;
    begin
      //TableViewTestListenerAppDelegate.TableViewController:title := 'EUnit — Running Rests';
    end;
    
    method TestStarted(Test: ITest); virtual;
    begin
      tests.addObject(Test);
      runningTest := Test;
      dispatch_async(dispatch_get_main_queue(), () -> TableViewTestListenerAppDelegate.tableViewController:reloadTests());
    end;
    
    method TestFinished(TestResult: ITestResult); virtual;
    begin
      runningTest := nil;
      testResults[TestResult.Test.Id] := TestResult;
      dispatch_async(dispatch_get_main_queue(), () -> TableViewTestListenerAppDelegate.tableViewController:reloadTests());
    end;
    
    method RunFinished(TestResult: ITestResult); virtual;
    begin
    end;
    
    { IEventListenerGUI }
    
    method PrepareGUI;
    begin
    end;

    method RunGUI;
    begin
      TableViewTestListenerAppDelegate.Listener := self;
      UIApplicationMain(0, nil, nil, nameOf(TableViewTestListenerAppDelegate))
    end;
    
    method FinishGUI;
    begin
      dispatch_async(dispatch_get_main_queue(), () -> begin
        TableViewTestListenerAppDelegate.TableViewController:title := 'EUnit — Done'
      end);
    end;
    
  end;
  
  [IBObject]
  TableViewTestListenerAppDelegate = public class

    property window: UIWindow;
    class property listener: TableViewTestListener;
    class property tableViewController: TestsTableViewController;

    method application(application: UIApplication) didFinishLaunchingWithOptions(launchOptions: NSDictionary): Boolean;
    begin
      tableViewController := new TestsTableViewController();
      window := new UIWindow();
      window.rootViewController := new UINavigationController withRootViewController(tableViewController);
      window.makeKeyAndVisible();
      result := true;
    end;
    
  end;

end.
