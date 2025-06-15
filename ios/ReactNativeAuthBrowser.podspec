#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AuthBrowserModule, NSObject)

RCT_EXTERN_METHOD(openAuth:(NSString *)url
                  scheme:(NSString *)scheme
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
