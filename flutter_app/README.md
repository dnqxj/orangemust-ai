# love app

## 版本

flutter sdk: 1.2.26

## 使用外部库

```yaml
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  # easy_loading
  flutter_easyloading: ^2.2.2
  cupertino_icons: ^1.0.0
  # 网络获取
  dio: ^3.0.10
  # 持久化操作
  shared_preferences: ^0.5.12+4
  # 缓存清理
  path_provider: ^1.6.27
  # 图片显示，可缓存
  ok_image: ^0.4.0
  # 屏幕适配
  flutter_screenutil: ^4.0.4+1
  image_picker: ^0.6.7+22
  # 日期选择
  flutter_datetime_picker: 1.5.0
  # 图形报表
  flutter_chart_csx: ^0.0.3
  # RSA加密
  encrypt: ^4.0.0
  # ui框架
  weui: 0.0.8
  left_scroll_actions: ^1.5.3
  # 极光推送，暂不使用
  #  jpush_flutter:
  #    git:
  #      url: git://github.com/jpush/jpush-flutter-plugin.git
  #      ref: master
  # 图片压缩
  flutter_luban: ^0.1.11
  # 全局状态管理
  provider: ^4.3.2+3
  # 轮播图
  flutter_swiper: ^1.1.6
```

## 目录结构

project 项目目录

```
├─apis                  接口目录
├─base                  公共基础
│  ├─view.dart          封装的公共widget方法
├─config                配置目录
│  ├─env.dart           环境配置
├─eventbus              订阅者
├─global                全局类
│  ├─Global.dart        网络访问
│  ├─global_theme.dart  配置主题选项
├─provider              全局状态管理
├─routes                路由
├─utils                 工具类
├─view                  视图
├─LICENSE.txt           授权说明文件
├─README.md             README 文件
```

## 运行配置

```shell

flutter run

--dart-define=DART_DEFINE_APP_ENV=debug

--dart-define=DART_DEFINE_APP_ENV=release

--dart-define=DART_DEFINE_APP_ENV=test
```

## apk 构建

flutter build apk --dart-define=DART_DEFINE_APP_ENV=release

apk 位置：build\app\outputs\flutter-apk\app-release.apk

## 日志

[2022-4-19] 项目搭建

[2022-4-20] 登录注册页面编写

[2022-4-21] home设置页面编写构建

[2022-4-22] 底部切换菜单完成

[2022-4-25] 图形AI页面基本完成


## 联系作者

邮箱：dnqxz@outlook.com
