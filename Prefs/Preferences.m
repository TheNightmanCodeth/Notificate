#import "Preferences.h"

@implementation NotificatePrefsListController
@synthesize respringButton;

- (instancetype)init {
    self = [super init];

    if (self) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];
        self.hb_appearanceSettings = appearanceSettings;
        self.respringButton = [[UIBarButtonItem alloc] initWithTitle:@"Respring"
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(respring:)];
        self.respringButton.tintColor = [UIColor redColor];
        self.navigationItem.rightBarButtonItem = self.respringButton;
    }

    return self;
}

- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Prefs" target:self] retain];
    }
    return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;
	
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.translucent = YES;
}

- (void)setCustomText:(id)sender {

}

- (void)testNotifications:(id)sender {
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"me.jdiggity.Notificate/TestNotifications", nil, nil, true);
}

- (void)testBanner:(id)sender {
   CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"me.jdiggity.Notificate/TestBanner", nil, nil, true);
}

- (void)resetPrefs:(id)sender {
    HBPreferences *prefs = [[HBPreferences alloc] initWithIdentifier:@"me.jdiggity.Notificate"];
    [prefs removeAllObjects];
    
    [self respring:sender];
}

- (void)respring:(id)sender {
    NSTask *t = [[[NSTask alloc] init] autorelease];
    [t setLaunchPath:@"/usr/bin/killall"];
    [t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
    [t launch];
}
@end

// Custom application settings page

@implementation NotificatePrefsCustomAppsController
- (instancetype)init {
    self = [super init];

    if (self) {
        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];
        self.hb_appearanceSettings = appearanceSettings;
    }

    return self;
}
- (id)specifiers {
    if (_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"CustomAppsPrefs" target:self] retain];
    }
    return _specifiers;
}

- (void)loadView {
    [super loadView];

    NSError *error;
    NSArray *appDirs = [[NSFileManager defaultManager] 
        contentsOfDirectoryAtPath:@"/Applications" error: &error];
    if (error != nil) {
        NSLog(@"Notificate.ERROR: Couldn't get NSFileManager");
        NSLog(@"%@", error.localizedDescription);
    }
    apps = [[NSMutableArray alloc]init];
    for (NSString *dir in appDirs) {
        NSArray *dotSep = [dir componentsSeparatedByString:@"."];
        NSString *appTitle = [dotSep objectAtIndex:0];
        [apps addObject:appTitle];
    }
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;
	
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.translucent = YES;
}

- (NSArray *)installedApps:(id)target {
    return apps;
}
- (NSArray *)installedVals:(id)target {
    return apps;
}
@end

@interface NotificatePrefsCustomAppsListItemController : PSListItemsController
@end

@implementation NotificatePrefsCustomAppsListItemController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;
	
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.translucent = YES;
}
@end