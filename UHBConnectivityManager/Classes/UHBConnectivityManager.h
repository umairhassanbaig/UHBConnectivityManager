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
/**
Shared instance that can be used anywhere.
 */
+(instancetype)shared;

/**
 Returns the current internet connectivity status
 */
-(ConnectivityManagerConnectionStatus)currentStaus;

/**
 Boolean value indicating wether the device is connected to internet or not
 */
-(BOOL)isConnected;
/**
 Returns true if device is connected to internet over mobile data instead of WIFI
 */
-(BOOL)isConnectedOverMobileData;
/**
 Registers a block to observe network changes against a unique identifier.
 @param callback Block that will be called on network change.
 @param uniqueId A callback block has to be registered against a unique identifier.
 */
-(void)registerCallBack:(ConnectivityManagerCallback)callback forIdentifier:(NSString *)uniqueId;
/**
 Removes registered network changes block aganst unique identifier.
 @param uniqueId Unique identifier.
 */
-(void)removeCallBackForIdentitfier:(NSString *)uniqueId;

@end





@interface NSObject (UHBAdditions)
/**
 Gives the unique memory address of object. Useful to register an object with registerCallback: forIdentifier:

 @return The memory address of the object in String
 */
-(NSString *)memoryAddress;

@end