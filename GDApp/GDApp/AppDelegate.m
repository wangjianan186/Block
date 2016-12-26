//
//  AppDelegate.m
//  GDApp
//
//  Created by Bigbang on 16/1/15.
//  Copyright © 2016年 Bigbang. All rights reserved.
//

#import "AppDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "FXBlurView.h"

@interface AppDelegate ()

@property (nonatomic, strong) FXBlurView *coverView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tbc = [[GDUITabBarController alloc] init];
    self.window.rootViewController = self.tbc;
    [self.window makeKeyAndVisible];
    
    [self doSomeAuth];
    [self resignAPNS];
    [self showAPPIconBadgeNumber];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.window addSubview:self.coverView];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.coverView removeFromSuperview];

}

- (void)applicationWillTerminate:(UIApplication *)application {
 
}

//改变状态栏调用的方法
- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame {
    NSString *rectString = NSStringFromCGRect(newStatusBarFrame);
    NSLog(@"- - - %@",rectString);
}

//获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"My token is:%@", token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //在此处理接收到的消息。
    NSLog(@"Receive remote notification : %@",userInfo);
    /*
     JAVA后台代码：
     
     public static void main(String[] args) throws Exception
     {
     try
     {
     //从客户端获取的deviceToken，在此为了测试简单，写固定的一个测试设备标识。
     String deviceToken = "df779eda 73258894 5882ec78 3ac7b254 6ebc66fe fa295924 440d34ad 6505f8c4"
     System.out.println("Push Start deviceToken:" + deviceToken);
     //定义消息模式
     PayLoad payLoad = new PayLoad();
     payLoad.addAlert("this is test!");
     payLoad.addBadge(1);//消息推送标记数，小红圈中显示的数字。
     payLoad.addSound("default");
     //注册deviceToken
     PushNotificationManager pushManager = PushNotificationManager.getInstance();
     pushManager.addDevice("iPhone", deviceToken);
     //连接APNS
     String host = "gateway.sandbox.push.apple.com";
     //String host = "gateway.push.apple.com";
     int port = 2195;
     String certificatePath = "c:/PushTest.p12";//前面生成的用于JAVA后台连接APNS服务的*.p12文件位置
     String certificatePassword = "123456";//p12文件密码。
     pushManager.initializeConnection(host, port, certificatePath, certificatePassword, SSLConnectionHelper.KEYSTORE_TYPE_PKCS12);
     //发送推送
     Device client = pushManager.getDevice("iPhone");
     System.out.println("推送消息: " + client.getToken()+"\n"+payLoad.toString() +" ");
     pushManager.sendNotification(client, payLoad);
     //停止连接APNS
     pushManager.stopConnection();
     //删除deviceToken
     pushManager.removeDevice("iPhone");
     System.out.println("Push End");
     }
     catch (Exception ex)
     {
     ex.printStackTrace();
     }
     }
     }
     */
}

#pragma mark - @selector

- (void)doSomeAuth {
    LAContext *myContext = [[LAContext alloc] init];
    myContext.localizedFallbackTitle = @"验证登录密码";
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"通过Home键验证已有手机指纹";
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError])
    {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if(success)
                                {
                                    //处理验证通过
                                    GDLog(@"验证通过");
                                }
                                else
                                {
                                    //处理验证失败
                                    GDLog(@"验证无效");
                                }
                            }];
    }
    else
    {
        //不支持Touch ID验证，提示用户
        NSLog(@"没有ID哦");
    }
}

- (void)resignAPNS {
    //消息推送注册
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge];
    /*
    Provider是指某个iPhone软件的Push服务器，这篇文章我将使用.net作为Provider。
    APNS 是Apple Push Notification Service（Apple Push服务器）的缩写，是苹果的服务器。
    后台可以分为三个阶段。
    第一阶段：Push服务器应用程序把要发送的消息、目的iPhone的标识打包，发给APNS。
    第二阶段：APNS在自身的已注册Push服务的iPhone列表中，查找有相应标识的iPhone，并把消息发到iPhone。
    第三阶段：iPhone把发来的消息传递给相应的应用程序， 并且按照设定弹出Push通知。
     
     APP端
     1、首先是应用程序注册消息推送。
     2、iOS跟APNS Server要deviceToken。应用程序接受deviceToken。
     3、应用程序将deviceToken发送给PUSH服务端程序。
     4、服务端程序向APNS服务发送消息。
     5、APNS服务将消息发送给iPhone应用程序。
     无论是iPhone客户端跟APNS,还是Provider和APNS都需要通过证书进行连接的。
     
     关于证书
     Development Push SSL Certificate ，与Production Push SSL Certificate 区别在于一个是用于开发的推送证书，一个是用于发布产品的推送证书。两个证书获取到的终端deviceToken是不一样的，用两个证书生成的P12证书用于JAVA后台连接APNS的服务器地址也是不同的，
     Development Push SSL Certificate 对应连接的服务器地址是：gateway.sandbox.push.apple.com。
     Production Push SSL Certificate  对应连接的服务器地址是：gateway.push.apple.com。
     */
}

- (void)showAPPIconBadgeNumber {
    UIApplication *application = [UIApplication sharedApplication];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
#ifdef __IPHONE_8_0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
#endif
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    application.applicationIconBadgeNumber = 8;
}

- (FXBlurView *)coverView {
    if (_coverView == nil) {
        _coverView = [[FXBlurView alloc] init];
        _coverView.frame = [UIScreen mainScreen].bounds;
        _coverView.dynamic = YES;
        _coverView.blurRadius = 10;
        _coverView.tintColor = [UIColor whiteColor];
    }
    return _coverView;
}

@end
