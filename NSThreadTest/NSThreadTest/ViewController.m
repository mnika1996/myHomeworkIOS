//
//  ViewController.m
//  NSThreaedTest
//
//  Created by Вероника on 05.12.17.
//  Copyright © 2017 Вероника. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Получаем количество активных процессоров, столько потоков и будем создавать
    self.maxThreadCount = [[NSProcessInfo processInfo] activeProcessorCount];
    
    // Создаем коллекцию для обработки
    NSArray *templateCollection = @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(14),@(15)];
    NSUInteger multiplier = 10000;
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:templateCollection.count*multiplier];
    for (NSUInteger i=0; i<=multiplier; ++i) {
        [tmp addObjectsFromArray:templateCollection];
    }
    self.collection = [tmp copy];
    
    Task* allThreadArgs[self.maxThreadCount]; // Массив структур
    
    // Рассчитываем рейнжи для частей массива и запускаем обработку
    NSUInteger addition = self.collection.count % self.maxThreadCount;
    
    NSTimeInterval startTime; // Измерение производительности
    NSTimeInterval endTime;
    
    
    startTime = [NSDate new].timeIntervalSince1970;
    
    self.condition = [[NSCondition alloc]init];
    
    // Fork
    for (NSUInteger i=0; i<self.maxThreadCount; ++i)
    {
        
        //NSUInteger i = 0;
        NSUInteger length = self.collection.count/self.maxThreadCount;
        NSUInteger step = self.collection.count/self.maxThreadCount;
        
        if ( addition!=0 && i==(self.maxThreadCount-1) ) {
            length = length+addition;
        }
        
        NSRange subarrayRange = NSMakeRange(i*step, length);
        
        // Создаем и заполняем структуру Task, через которую будут переданы аргументы в поток
        Task *args = malloc(sizeof(Task));
        args->threadID = i;
        args->range = subarrayRange;
        args->finished = false;
        args->sum = 0;
        allThreadArgs[i] = args;
        
        // Запуск потока
        [NSThread detachNewThreadWithBlock:^(void){
            NSRange range = args->range;
            NSUInteger sum = 0;
            
            for (NSUInteger i=range.location; i<(range.location+range.length);++i) {
                sum = sum + self.collection[i].integerValue;
                // NSLog(@"Thread: %lu number: %@", arguments->threadID, number);
            }
            args->finished = true;
            args->sum = sum;
            
            // Реализация шаблона "Ожидание на условной переменной"
            [self.condition lock];
            [self.condition signal];
            [self.condition unlock];
        }];
    }
    
    // Реализация шаблона "Ожидание на условной переменной"
    [self.condition lock];
    while (![self checkCondition: allThreadArgs])
    {
        // Condvar waiting
        
        [self.condition wait];
        
    }
    [self.condition unlock];
    
    // Рассчет результата
    NSUInteger result = 0;
    for (NSUInteger i=0; i<self.maxThreadCount; ++i) {
        Task* args = allThreadArgs[i];
        result = result + args->sum;
    }
    NSLog(@"Fork-join result %lu", result);
    
    // Очистка памяти
    for (NSUInteger i=0; i<self.maxThreadCount; ++i) {
        Task* args = allThreadArgs[i];
        free(args);
        args = NULL;
    }
    
    endTime = [NSDate new].timeIntervalSince1970;
    NSLog(@"Fork-join measured time %f", endTime-startTime);
}

-(bool)checkCondition:(Task **)threadArguments {
    bool result = true;
    for (NSUInteger i=0; i<self.maxThreadCount; ++i) {
        result = result & threadArguments[i]->finished;
    }
    return result;
}

@end
