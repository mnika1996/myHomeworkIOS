//
//  ViewController.h
//  NSThreaedTest
//
//  Created by Вероника on 05.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import <UIKit/UIKit.h>

// Task struct
typedef struct Task {
    NSRange range; // Рейнж части исходной коллекции которую будем обрабатывать
    NSUInteger threadID;
    bool finished; // Признак окончания таска (используется для возврата значения)
    NSUInteger sum; // Сумма элментов возвращаемой части коллекции (используется для возврата значения)
} Task;


@interface ViewController : UIViewController

@property (strong, nonatomic) NSCondition *condition;

// Параллельный обход массива и подсчет суммы
@property NSArray<NSNumber *> *collection;
@property NSUInteger maxThreadCount;

@end

