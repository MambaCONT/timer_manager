# timer_manager
![ss](https://github.com/MambaCONT/CustomPopView/blob/main/imags/1637057244035.jpeg?raw=true "BSlogo")

# timer_manager
一个多个timer的管理类
===========================
****

|Author|BlackSnake|
|---|---

****

支持多个timer的使用，储存，取消

### 使用举例：


```Java
///如果不存在此key的timer，就反回成功
static String timerKey = 'timerKey';
bool createdSuccess = TimerManager.instance.startTimer(timerKey, duration,
        asyncBloc: _handlerNewCheckTimerEvent);
        
///取消定时器
TimerManager.instance.cancelTimer(timerKey);
    
