//
//  EventKitTestViewController.m
//  TestDemo
//
//  Created by vane on 15/2/27.
//  Copyright (c) 2015年 vane.greenisland. All rights reserved.
//

#import "EventKitTestViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface EventKitTestViewController ()

@end

@implementation EventKitTestViewController
{
    UIButton *addEventBtn;
    UIButton *deleteEventBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    addEventBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 120, 40)];
    [addEventBtn setTitle:@"添加会议事件" forState:UIControlStateNormal];
    [addEventBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addEventBtn addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
    
    deleteEventBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 120, 40)];
    [deleteEventBtn setTitle:@"删除日历事件" forState:UIControlStateNormal];
    [deleteEventBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [deleteEventBtn addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addEventBtn];
    [self.view addSubview:deleteEventBtn];
}

- (void)addEvent
{
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        if (!granted)
            return;
        
        EKEvent *myEvent = [EKEvent eventWithEventStore:eventDB];
        
        myEvent.title = @"会议通知";
        myEvent.notes = @"详细描述&备注";
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        
        myEvent.startDate = [NSDate date];
        myEvent.endDate = [myEvent.startDate dateByAddingTimeInterval:60*60];//结束时间1小时之后
        
        [myEvent addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
        
        [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
        NSError *err = nil;
        [eventDB saveEvent:myEvent span:EKSpanThisEvent commit:YES error:&err];
        
        NSString *saveEventId = myEvent.eventIdentifier;
        
        NSLog(@"保存成功,EventId:%@",saveEventId);
    }];
}

- (void)deleteEvent
{
    NSString *deleteEventId = @"2CFF8FCD-77EF-4837-8A12-7CB29E7EE7F4:B727B98D-C658-42D5-BE86-D01FD8D14748";
    
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error){
        if (!granted)
            return;
        EKEvent *eventToRemove = [eventDB eventWithIdentifier:deleteEventId];
        if (eventToRemove) {
            NSError *err = nil;
            [eventDB removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&err];
            NSLog(@"删除成功");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
