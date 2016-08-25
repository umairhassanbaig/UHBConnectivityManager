//
//  ConnectivityManager.m
//  VideoDownloader
//
//  Created by Umair Hassan Baig on 1/18/15.
//  Copyright (c) 2015 OS_Umair. All rights reserved.
//

#import "UHBConnectivityManager.h"
#import "Reachability.h"

static UHBConnectivityManager * sharedInstance;


@interface UHBConnectivityManager ()
@property (nonatomic, strong) NSMutableDictionary * callbacksTrace;
@property (nonatomic, retain) Reachability * reachability;
@end

@implementation UHBConnectivityManager

+(instancetype)shared
{
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.callbacksTrace = [NSMutableDictionary dictionary];
        self.reachability = [Reachability reachabilityForInternetConnection];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityNotifictaionRecieved:) name:kReachabilityChangedNotification object:self.reachability];
        [self.reachability startNotifier];
        
    }
    return  self;
}

-(void)dealloc
{
    [self.callbacksTrace removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.reachability stopNotifier];
    self.reachability = nil;
}

-(void)reachabilityNotifictaionRecieved:(NSNotification *)notif
{
    Reachability * reachability = notif.object;
    
       NSArray * keys = [self.callbacksTrace allKeys];
       NSArray * callbacks = [self.callbacksTrace objectsForKeys:keys notFoundMarker:@""];
        for (int i = 0; i < callbacks.count; i++) {
            if ([callbacks[i] isKindOfClass:[NSString class]]) {
                continue;
            }
            ConnectivityManagerCallback callback = callbacks[i];
            
            if (reachability.currentReachabilityStatus == NotReachable)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(ConnectivityManagerConnectionStatusDisconnected);
                });
                
            }
            else
            {   dispatch_async(dispatch_get_main_queue(), ^{
                    callback(ConnectivityManagerConnectionStatusConnected);
                });
            }
        }
    
}

-(void)registerCallBack:(ConnectivityManagerCallback)callback forIdentifier:(NSString *)uniqueId
{
    [self.callbacksTrace setObject:[callback copy] forKey:uniqueId];
}

-(void)removeCallBackForIdentitfier:(NSString *)uniqueId
{
    [self.callbacksTrace removeObjectForKey:uniqueId];
}

-(ConnectivityManagerConnectionStatus)currentStaus
{
    if (self.reachability.currentReachabilityStatus == NotReachable) {
        return ConnectivityManagerConnectionStatusDisconnected;
    }
    return ConnectivityManagerConnectionStatusConnected;
}

-(BOOL)isConnected
{
    return self.reachability.currentReachabilityStatus != NotReachable;
}

-(BOOL)isConnectedOverMobileData
{
    return self.reachability.currentReachabilityStatus == ReachableViaWWAN;
}


@end


@implementation NSObject (UHBAdditions)


-(NSString *)memoryAddress
{
    return [NSString stringWithFormat:@"%p",  self];
}
@end

