//
//  AlgorithmTestVC.m
//  TestDemo
//
//  Created by vane on 06/12/2017.
//  Copyright © 2017 vane.greenisland. All rights reserved.
//

#import "AlgorithmTestVC.h"

@interface AlgorithmTestVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AlgorithmTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"冒泡排序(Bubble Sort)";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"选择排序(Simple Selection Sort)";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"插入排序(Straight Insertion Sort)";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"希尔排序(Shell Sort)";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"堆排序(Heap Sort)";
    } else if (indexPath.row == 5) {
        cell.textLabel.text = @"归并排序(Merging Sort)";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"快速排序(Quick Sort)";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *list = [NSMutableArray arrayWithArray:@[@8,@7,@6,@5,@4,@3,@2,@1]];
    
    if (indexPath.row == 0) {
        [self logArrayFunctionNice];
    } else if (indexPath.row == 1) {
        [self logChooseArray];
    } else if (indexPath.row == 2) {
        [self logInsertionSortingArray];
    } else if (indexPath.row == 3) {
        [self shellSort:list];
    } else if (indexPath.row == 4) {
        [self heapSort:list];
    } else if (indexPath.row == 5) {
        [self megerSortAscendingOrderSort:list];
    } else if (indexPath.row == 6) {
        NSMutableArray * arr = @[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10].mutableCopy;
        [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count-1];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - Algorithm

//冒泡：http://www.jianshu.com/p/e3294692966e
- (void)logArrayFunctionNice {
    int count  = 0;
    int forcount  = 0;
    BOOL flag = YES;
    NSMutableArray * arr = @[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10].mutableCopy;
    
    for (int i = 0; i < arr.count && flag; i++) {
        forcount++;
        flag = NO;
        for (int j = (int)arr.count-2; j >= i; j--) {
            count++;
            if (arr[j] < arr[j+1]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = YES;
            }
        }
        [self logArr:arr];
    }
    NSLog(@"循环次数：%d",forcount);
    NSLog(@"共%d次比较",count);
}

- (void)logArr:(NSMutableArray * )array {
    NSString * str = @"";
    for (NSNumber * value in array) {
        str = [str stringByAppendingString:[NSString stringWithFormat:@"%zd ",[value integerValue]]];
    }
    NSLog(@"%@",str);
}

//选择：http://www.jianshu.com/p/ec58c2794daf
- (void)logChooseArray {
    NSMutableArray * arr = @[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10].mutableCopy;
    int min = 0, arrCount = (int)arr.count;
    for (int i = 0; i < arrCount-1; i++) {
        min = i;
        for (int j = i + 1; j < arrCount; j++) {
            if (arr[min] > arr[j]) {  /*如果有小于当前的最小值的关键字*/
                min = j;  /*将此关键字的下标赋值给min*/
            }
        }
        if (i != min) {  /*若min不等于i，说明找到最小值，交换*/
            [arr exchangeObjectAtIndex:i withObjectAtIndex:min];
        }
    }
}

//插入：http://www.jianshu.com/p/d50eac247452
- (void)logInsertionSortingArray {
    NSMutableArray * arr = @[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10].mutableCopy;
    for (int i = 1; i < arr.count; i++) {
        int j = i;  /* j是一个坑， 确定坑的位置，再把数从坑里取出来，注意顺序*/
        id temp = arr[i];  /* temp 是从坑里取数*/
        if (arr[i] < arr[i-1]) {  /* j > 0 防止越界。写&&前面效率更高*/
            temp = arr[i];
            while (j > 0 && [temp intValue] < [arr[j-1] intValue]) {
                arr[j] = arr[j-1];
                j--;
            }
            arr[j] = temp;
        }
    }
}

//希尔：http://www.jianshu.com/p/c74dd2954b8e
//起始间隔值gap设置为总数的一半，直到gap==1结束
-(void)shellSort:(NSMutableArray *)list{
    int gap = (int)list.count / 2;
    while (gap >= 1) {
        for(int i = gap ; i < [list count]; i++){
            NSInteger temp = [[list objectAtIndex:i] intValue];
            int j = i;
            while (j >= gap && temp < [[list objectAtIndex:(j - gap)] intValue]) {
                [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-gap]];
                j -= gap;
            }
            [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        }
        gap = gap / 2;
    }
}

//堆：http://www.jianshu.com/p/fe271bc3e544
- (void)heapSort:(NSMutableArray *)list
{
    NSInteger i ,size;
    size = list.count;
    //找出最大的元素放到堆顶
    for (i= list.count/2; i>=0; i--) {
        [self createBiggesHeap:list withSize:size beIndex:i];
    }
    
    while(size > 0){
        [list exchangeObjectAtIndex:size-1 withObjectAtIndex:0]; //将根(最大) 与数组最末交换
        size -- ;//树大小减小
        [self createBiggesHeap:list withSize:size beIndex:0];
    }
    NSLog(@"%@",list);
}

- (void)createBiggesHeap:(NSMutableArray *)list withSize:(NSInteger) size beIndex:(NSInteger)element
{
    NSInteger lchild = element *2 + 1,rchild = lchild+1; //左右子树
    while (rchild < size) { //子树均在范围内
        if (list[element]>=list[lchild] && list[element]>=list[rchild]) return; //如果比左右子树都大，完成整理
        if (list[lchild] > list[rchild]) { //如果左边最大
            [list exchangeObjectAtIndex:element withObjectAtIndex:lchild]; //把左面的提到上面
            element = lchild; //循环时整理子树
        }else{//否则右面最大
            [list exchangeObjectAtIndex:element withObjectAtIndex:rchild];
            element = rchild;
        }
        
        lchild = element * 2 +1;
        rchild = lchild + 1; //重新计算子树位置
    }
    //只有左子树且子树大于自己
    if (lchild < size && list[lchild] > list[element]) {
        [list exchangeObjectAtIndex:lchild withObjectAtIndex:element];
    }
}

//归并：http://www.jianshu.com/p/04d9480a0633
- (void)megerSortAscendingOrderSort:(NSMutableArray *)ascendingArr
{
    //tempArray数组里存放ascendingArr个数组，每个数组包含一个元素
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
    for (NSNumber *num in ascendingArr) {
        NSMutableArray *subArray = [NSMutableArray array];
        [subArray addObject:num];
        [tempArray addObject:subArray];
    }
    //开始合并为一个数组
    while (tempArray.count != 1) {
        NSInteger i = 0;
        while (i < tempArray.count - 1) {
            tempArray[i] = [self mergeArrayFirstList:tempArray[i] secondList:tempArray[i + 1]];
            [tempArray removeObjectAtIndex:i + 1];
            i++;
        }
    }
    NSLog(@"归并升序排序结果：%@", tempArray[0]);
}

- (NSArray *)mergeArrayFirstList:(NSArray *)array1 secondList:(NSArray *)array2 {
    NSMutableArray *resultArray = [NSMutableArray array];
    NSInteger firstIndex = 0, secondIndex = 0;
    while (firstIndex < array1.count && secondIndex < array2.count) {
        if ([array1[firstIndex] floatValue] < [array2[secondIndex] floatValue]) {
            [resultArray addObject:array1[firstIndex]];
            firstIndex++;
        } else {
            [resultArray addObject:array2[secondIndex]];
            secondIndex++;
        }
    }
    while (firstIndex < array1.count) {
        [resultArray addObject:array1[firstIndex]];
        firstIndex++;
    }
    while (secondIndex < array2.count) {
        [resultArray addObject:array2[secondIndex]];
        secondIndex++;
    }
    return resultArray.copy;
}

//快速：http://www.jianshu.com/p/65b5d66e5c72
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            j--;
        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            i++;
        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}

@end
