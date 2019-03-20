/***
 *  Notificate.xm
 *
 *  This file is a part of the Notificate Project
 *
 *  Notificate is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This porogram is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *  Created by Joe Diragi on 3/19/19.
 *  Copyright © 2019 TheNightmanCodeth. All rights reserved.
 ***/

NSString *replace (NSString *replaceThis, NSString *withThis) {
    NSString *holder = [replaceThis copy];
    
    holder = [holder stringByReplacingOccurrencesOfString:replaceThis withString:withThis];
    return holder;
}

%group NotificateAll
%hook NCNotificationContentView

-(void)setPrimaryText:(NSString *)orig {
    if (!orig) {
        %orig(orig);
        return;
    }
    
    %orig(replace(@"the", @"game"));
}

%end
%end

%ctor {
    if (! [NSProcessInfo processInfo]) return;
    NSString *processName = [NSProcessInfo processInfo].processName;
    bool isSpringboard = [@"SpringBoard" isEqualToString:processName];
    
    HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"me.jdiggity.notificate"];
    
    // Here we use `file` and look for the value of the `Enabled` key to see if we're enabled.
    // If the key is not found, the default value is defined YES/True
    if ([([file objectForKey:@"Enabled"] ?: @(YES)) boolValue]) {
        if ([([file objectForKey:@"NotificateAll"] ?: @(NO)) boolValue]) {
            %init(NotificateAll);
        }
    }
}
