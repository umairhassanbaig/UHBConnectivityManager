//
//  ConnectivityManager.h
//  VideoDownloader
//
//  Created by Umair Hassan Baig on 1/18/15.
//  Copyright (c) 2015 OS_Umair. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ConnectivityManagerConnectionStatusConnected,
    ConnectivityManagerConnectionStatusDisconnected
    
}ConnectivityManagerConnectionStatus;

typedef void (^ConnectivityManagerCallback)(ConnectivityManagerConnectionStatus status);


@interface UHBConnectivityManager : NSObject

+(instancetype)shared;
-(ConnectivityManagerConnectionStatus)currentStaus;
-(BOOL)isConnected;
-(BOOL)isConnectedOverMobileData;
-(void)registerCallBack:(ConnectivityManagerCallback)callback forIdentifier:(NSString *)uniqueId;
-(void)removeCallBackForIdentitfier:(NSString *)uniqueId;

@end
