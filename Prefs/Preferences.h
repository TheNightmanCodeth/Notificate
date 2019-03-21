#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>
#import "NSTask.h"

@interface NotificatePrefsListController : HBRootListController
    @property (nonatomic, retain) UIBarButtonItem *respringButton;
    - (void)resetPrefs:(id)sender;
    - (void)respring:(id)sender;
    - (void)testNotifications:(id)sender;
    - (void)testBanner:(id)sender;
    - (void)setCustomText:(id)sender;
@end
