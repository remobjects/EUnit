namespace Echoes.Tests.WP8;

interface

uses
  System,
  System.Collections.Generic,
  System.Linq,
  System.Net,
  System.Windows,
  System.Windows.Controls,
  System.Windows.Media,
  System.Windows.Navigation,
  Microsoft.Phone.Controls,
  Microsoft.Phone.Shell,
  Echoes.Tests.WP8.Resources;

type
  MainPage = public partial class(PhoneApplicationPage)

  public
    // Constructor
    constructor ;

  end;

implementation

constructor MainPage;
begin
  InitializeComponent()

  // Sample code to localize the ApplicationBar
  //BuildLocalizedApplicationBar();
end;

//method MainPage.BuildLocalizedApplicationBar;
//begin
  // Set the page's ApplicationBar to a new instance of ApplicationBar.
  //ApplicationBar := new ApplicationBar();

  // Create a new button and set the text value to the localized string from AppResources.
  //var appBarButton: ApplicationBarIconButton := new ApplicationBarIconButton(new Uri('/Assets/AppBar/appbar.add.rest.png', UriKind.Relative));
  //appBarButton.Text := AppResources.AppBarButtonText;
  //ApplicationBar.Buttons.Add(appBarButton);

  // Create a new menu item with the localized string from AppResources.
  //var appBarMenuItem: ApplicationBarMenuItem := new ApplicationBarMenuItem(AppResources.AppBarMenuItemText);
  //ApplicationBar.MenuItems.Add(appBarMenuItem)
//end;

end.