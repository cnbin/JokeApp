//
//  main.m
//  你笑了吗
//
//  Created by Apple on 10/21/15.
//  Copyright © 2015 cnbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
          [NBSAppAgent startWithAppID:@"6d57006aeba141d3b08bb02ddf1ddc0d"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
