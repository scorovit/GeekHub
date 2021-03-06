//
//  main.m
//  Obj-C-LineAndArray
//
//  Created by Nikolay Dementiev on 26.10.16.
//  Copyright © 2016 mc373. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleLineClass: NSObject

//1 - Lines
- (void) calculateTheMinimumAndMaximumNumberOfCharactersPerLine;
- (void) calculateHowManyDifferentSymbolsOccursOnLine;
- (void) findTheWordThatBeginsAndEndsWithTheSameLetter;
- (void) findTheAmountOfAvailableNumbersInTheText;
- (void) checkWhetherItIsPossibleToReadTheSameWordInTwoDirections;
- (void) implementTheCodeSandwich;

//2 Arrays
- (void) countTheNumberOfPositiveNegativeZeroElementsInTheArray;
- (void) swapTheLargestAndSmallestElementsInTheArray;
- (void) increasingSequenceOfMaximalLengthInArray;

// helper
+ (NSString *) removeSpecialSymbolsInTheLine: (NSString *)line;
+ (NSArray*) getFilteredArrayWithPredicate: (NSString*)strPredicate arrayForWork:(NSArray*)arrayWork;
+ (NSString*) formatingStr: (NSString*)str arrayForWork:(NSArray*)arrayWork;
@end


@implementation SampleLineClass

//MARK: - Lines

//MARK: #1 - lines
- (void) calculateTheMinimumAndMaximumNumberOfCharactersPerLine {
		NSLog(@ "\n #1 - lines - CalculateTheMinimumAndMaximumNumberOfCharactersPerLine");

		NSString *lineForTest = @"Дана строка, содержащая текст. Найти длину самого короткого слова и самого длинного слова.";


		lineForTest = [SampleLineClass removeSpecialSymbolsInTheLine: lineForTest];

		//1 Break the line by words
		NSMutableArray *parts = [NSMutableArray arrayWithArray:
														 [lineForTest componentsSeparatedByCharactersInSet:
															[NSCharacterSet  whitespaceCharacterSet]]];

		[parts removeObject:@""];

		// calculate
		NSMutableString *res;
		int maxCount = 0;
		int minCount = 0;
		BOOL firstIn = TRUE;
		for (int ind = 0; ind < parts.count; ind++) {
				res = [parts objectAtIndex: ind];

				int countRes = (int)[res length];
				maxCount = countRes > maxCount ? countRes : maxCount;

				if (firstIn && countRes > 0) {
						firstIn = FALSE;
						minCount = countRes;
				} else {
						minCount = countRes < minCount ? countRes : minCount;
				}

		}

		NSLog(@"max. length = '%d'; min. length = '%d'.", maxCount, minCount);
}

//MARK: #2 - lines

-(void) calculateHowManyDifferentSymbolsOccursOnLine {
		NSLog(@ "\n #2 - lines - CalculateHowManyDifferentSymbolsOccursOnLine");

		NSString *lineForTest = @"Дана строка. Подсчитать, сколько различных символов встречается в ней. Вывести их на экран";

		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

		for (int i=0; i<[lineForTest length];i++) {
				NSString *chr = [lineForTest substringWithRange:NSMakeRange(i,1)];

				NSNumber *elementValue = [dictionary valueForKey:chr];

				NSNumber *count;
				if (elementValue != NULL) {
						int value = [elementValue intValue];
						count = [NSNumber numberWithInt: value+1];
				} else {
						count = @1;
				}

				[dictionary setValue:count forKey:chr];
		}

		//print result
		NSString * strOutPut = @"";
		for(NSString *key in [dictionary allKeys]) {
				strOutPut = [strOutPut stringByAppendingFormat: @"%@'%@'(%@)" ,([strOutPut length] > 0 ? @", ": @" "), key, [dictionary valueForKey:key]];
		}
		NSLog(@ "Symbol calc result (format is: ''symbol' (occurs times)'): \n %@", strOutPut);

}

//MARK: #3 - lines

- (void) findTheWordThatBeginsAndEndsWithTheSameLetter {
		NSLog(@ "\n #3 - lines - FindTheWordThatBeginsAndEndsWithTheSameLetter");

		NSString *lineForTest = @"Дана строкас. Найти в ней те слова, которые начинаются и оканчиваются одной и той же буквой.";

		lineForTest = [SampleLineClass removeSpecialSymbolsInTheLine: lineForTest];

		//1 Break the line by words
		NSMutableArray *parts = [NSMutableArray arrayWithArray:
														 [lineForTest componentsSeparatedByCharactersInSet:
															[NSCharacterSet  whitespaceCharacterSet]]];

		[parts removeObject:@""];

		NSString *res;
		NSString *firstLetter;
		NSString *lastLetter;

		NSMutableArray* theSameLetterWords = [NSMutableArray new];

		for (int ind = 0; ind < parts.count; ind++) {
				res = [parts objectAtIndex: ind];

				int countRes = (int)[res length];
				if (countRes > 0) {
						firstLetter = [res substringToIndex: 1];
						lastLetter = [res substringFromIndex: countRes-1];

						if ([firstLetter caseInsensitiveCompare:lastLetter] == NSOrderedSame) {
								//strings are same
								NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", res];
								NSArray *results = [theSameLetterWords filteredArrayUsingPredicate:predicate];

								if ([results count] == 0) {
										[theSameLetterWords addObject:res];
								}
						}
				}
		}

		//Output the results of calculations

		NSString * strOutPut = @"";
		for(id element in theSameLetterWords) {
				strOutPut = [strOutPut stringByAppendingFormat: @"%@'%@'" ,
										 ([strOutPut length] > 0 ? @", ": @" "),
										 [element description]];
		}

		NSLog(@ "Words that begins and ends with the same letter:  %@", strOutPut);
}

//MARK: #4 - lines

- (void) findTheAmountOfAvailableNumbersInTheText {
		NSLog(@ "\n #4 - lines - FindTheAmountOfAvailableNumbersInTheText");

		NSString *lineForTest = @"Дан1 текст23. 32 Найти сумму имею456щихся в0.34 нем ц5ифр.";
		NSString *dotSymbol = @".";

		NSMutableString *strippedString = [NSMutableString new];
		for (int i=0; i<[lineForTest length]; i++) {
				unichar cType = [lineForTest characterAtIndex:i];
				unichar chDot = [dotSymbol characterAtIndex:0];
				if (isdigit(cType) || cType == chDot) {
						[strippedString appendFormat:@"%c",[lineForTest characterAtIndex:i]];
				} else {
						[strippedString appendFormat:@"%@",@" "];
				}
		}

		NSMutableArray *parts = [NSMutableArray arrayWithArray:
														 [strippedString componentsSeparatedByCharactersInSet:
															[NSCharacterSet  whitespaceCharacterSet]]];

		[parts removeObject: @""];
		// let's delete self-staying dot symbol
		[parts removeObject: dotSymbol];

		float resultOfCalc = 0;

		NSString* strOuput = @"";
		int step = 0;
		while (step < [parts count]) {
				NSString* strTemp = [parts objectAtIndex: step];

				if ([strTemp containsString: dotSymbol]) {
						if ([strTemp hasPrefix: dotSymbol] || [strTemp hasSuffix: dotSymbol]) {
								//smth went wrong! Let's say it..
								NSLog(@"Something is wrong in expression '%@'! Symbol '%@' cann't stay at the beginning or at the end of expression. Current step was passed.", strTemp, dotSymbol);

								step++;
								continue;
						}
				}

				strOuput = [strOuput stringByAppendingFormat: @"%@ + ",strTemp];
				resultOfCalc = resultOfCalc +  [strTemp floatValue];

				step++;
		}

		//delete excess tail in expression
		NSRange excessTail = [strOuput rangeOfString:@" + " options:NSBackwardsSearch];
		if(excessTail.location != NSNotFound) {
				strOuput = [strOuput stringByReplacingCharactersInRange:excessTail withString: @""];
		}

		//Output the results of calculations
		NSLog(@ "Resulst of expresssion '%@' = '%.02f'", strOuput, resultOfCalc);

}

//MARK: #5 - lines

- (void) checkWhetherItIsPossibleToReadTheSameWordInTwoDirections {
		NSLog(@ "\n #5 - lines - CheckWhetherItIsPossibleToReadTheSameWordInTwoDirections");
		//Проверьте, является ли слово палиндромом (одинаково читается во всех направлениях)

		NSString *lineForTest = @"Доввод";

		//reverse string
		NSString *reverString = @"";
		for (int i = (int)[lineForTest length]; i > 0; i--) {
				unichar c = [lineForTest characterAtIndex: i-1];
				reverString = [reverString stringByAppendingFormat:@"%C", c];
		}

		BOOL stringIsEqualToReverse = [[lineForTest lowercaseString] isEqualToString: [reverString lowercaseString]];

		//Output the results of calculations
		NSLog(@ "Resulst of expresssion '%@' %@ a palindrome", lineForTest, stringIsEqualToReverse ? @"is" : @"isn't");
}

//MARK: #6 - lines

- (void) implementTheCodeSandwich {

		NSLog(@ "\n #6 - lines - ImplementTheCodeSandwich");
		/*Шифр "Сэндвич".  Дан текст. Осуществить шифрование и дешифрование
		 следующим образом: текст разбивается на две одинаковых по количеству
		 символов части и результатом шифрования является строка, в которой
		 символы из первой части чередуются символами из второй части.*/

		NSString* stringForWork = @"следующим образом: текст разбивается на две одинаковых по количеству символов части и результатом шифрования является строка, в которой";

		NSString *encodeStr = [SampleLineClass codeSandwichEncodeAString: &stringForWork];
		NSString *decodedStr = [SampleLineClass codeSandwichDecodeAString: encodeStr];

		//Output the results of calculations
		NSLog(@ "Resulst: \n 1. original line = '%@'\n 2. encoded line = '%@'\n 3. decoded line = '%@' \n4. 'orig. line' is equel to 'decoded line' = %@"
					, stringForWork
					, encodeStr
					, decodedStr
					, ([stringForWork isEqualToString: decodedStr] ? @"YES, all work fine" : @"NO, there is some mistake"));

}



+ (NSString* ) codeSandwichEncodeAString: (NSString**)inputString {

		NSUInteger breakPoint = [*inputString length]/2;

		NSString *firstStr = [*inputString substringToIndex: breakPoint];
		NSString *secondStr = [*inputString substringFromIndex: breakPoint];

		NSMutableString *sandwichStr = [NSMutableString new];

		int minLenth = (int)MIN((int)[firstStr length], (int)[secondStr length]);

		for (int i=0; i< minLenth; i++) {
				NSString *symbolstr1 = [NSString stringWithFormat: @"%C", [firstStr characterAtIndex: i]];
				NSString *symbolStr2 = [NSString stringWithFormat: @"%C", [secondStr characterAtIndex: i]];

				[sandwichStr appendFormat:@"%@%@",symbolstr1,symbolStr2];
		}

		if (([*inputString length]%(breakPoint*2)) != 0) {

				[sandwichStr appendFormat:@"%@",[SampleLineClass getSpecialSymbol]];

				//second string must have one more symbol then first
				NSString *symbolStr2 = [NSString stringWithFormat: @"%C", [secondStr characterAtIndex: ([secondStr length]-1)]];
				[sandwichStr appendFormat:@"%@",symbolStr2];
		}

		return sandwichStr;
}

+ (NSString* ) getSpecialSymbol {
		return @"$";
}

+ (NSString* ) codeSandwichDecodeAString: (NSString*)encodeStr {
		NSString *stringForReturn;

		NSMutableString *firstStr = [NSMutableString new];
		NSMutableString *secondStr = [NSMutableString new];

		NSString *specSymbol = [SampleLineClass getSpecialSymbol];
		NSString *symbolstr;
		for (int i=0; i < [encodeStr length]; i++) {

				symbolstr = [encodeStr substringWithRange:NSMakeRange(i, 1)];

				if (([symbolstr isEqualToString: specSymbol]) && (i == (((int)[encodeStr length])-2))) {
						continue;
				}

				if (i%2 == 0) {
						[firstStr appendFormat:@"%@", symbolstr];
				} else {
						[secondStr appendFormat:@"%@",symbolstr];
				}
		}

		stringForReturn = [NSString stringWithFormat:@"%@%@", firstStr, secondStr];

		return stringForReturn;
}

//MARK: - Arrays

//MARK: #1 - arrays

- (void) countTheNumberOfPositiveNegativeZeroElementsInTheArray {
		NSLog(@ "\n #1 - arrays - CountTheNumberOfPositiveNegativeZeroElementsInTheArray");
		//Дан массив действительных чисел, размерность которого N.
		//Подсчитать, сколько в нем отрицательных, положительных и нулевых элементов.

		NSArray *arrayOfNumbers = @[@1, @2, @33, @-2, @-5, @0];
		NSArray *arrayOfNumbersTemp;
		NSString *strCalcValue = @"";

		//1 - arrayOfLessThenZero
		arrayOfNumbersTemp = [SampleLineClass getFilteredArrayWithPredicate:@"SELF < %f" arrayForWork:arrayOfNumbers];
		strCalcValue = [strCalcValue stringByAppendingString: [SampleLineClass formatingStr:@"Less Then Zero '%@' elment/s." arrayForWork:arrayOfNumbersTemp]];

		//2 - arrayOfMoreThenZero
		arrayOfNumbersTemp = [SampleLineClass getFilteredArrayWithPredicate:@"SELF > %f" arrayForWork:arrayOfNumbers];
		strCalcValue = [strCalcValue stringByAppendingString: [SampleLineClass formatingStr:@"; More Then Zero '%@' elm." arrayForWork:arrayOfNumbersTemp]];

		//3 - arrayOfEquelToZero
		arrayOfNumbersTemp = [SampleLineClass getFilteredArrayWithPredicate:@"SELF = %f" arrayForWork:arrayOfNumbers];
		strCalcValue = [strCalcValue stringByAppendingString: [SampleLineClass formatingStr:@"; Equel To Zero '%@' elm." arrayForWork:arrayOfNumbersTemp]];

		//Output the results of calculations
		NSLog(@ "Resulst of expresssion. Current array has: '%@'", strCalcValue);
}

//MARK: #2 - arrays

- (void) swapTheLargestAndSmallestElementsInTheArray {
		NSLog(@ "\n #2 - arrays - SwapTheLargestAndSmallestElementsInTheArray");
		//		Даны действительные числа а1, а2,..., аn.
		//		Поменять местами наибольший и наименьший элементы.

		NSString *strOutput = @"";
		NSMutableArray *arrayOfNumbers = [NSMutableArray arrayWithObjects: @1, @2, @33, @-2, @-5, @0, nil];

		if ([arrayOfNumbers count] >= 2) {
				NSArray *arraySorted = [arrayOfNumbers sortedArrayUsingSelector: @selector(compare:)];

				NSNumber *maxValueInArray = arraySorted[[arraySorted count]-1];
				NSNumber *minValueInArray = arraySorted[0];

				int indMax = (int)[arrayOfNumbers indexOfObject: maxValueInArray];
				int indMin = (int)[arrayOfNumbers indexOfObject: minValueInArray];

				//swapping...
				arrayOfNumbers[indMax] = minValueInArray;
				arrayOfNumbers[indMin] = maxValueInArray;

				strOutput = [strOutput stringByAppendingFormat: @"Swapping the largest and smallest elements were successful! \n Elements '%@'(ind. = '%d') & '%@'(ind. = '%d') were swapped", minValueInArray, indMin, maxValueInArray, indMax];

		} else {
				strOutput = [strOutput stringByAppendingString: @"Input array must have more then two elements for swapping!"];
		}

		//Output the results of calculations
		NSLog(@ "%@", strOutput);
}

//MARK: #3 - arrays

- (void) increasingSequenceOfMaximalLengthInArray {
		NSLog(@ "\n #3 - arrays - IncreasingSequenceOfMaximalLengthInArray");
		//Удалить в заданном массиве элементы так,
		//чтобы оставшиеся образовывали возрастающую последовательность наибольшей длины

		NSArray *arrayOfNumbers = [NSArray arrayWithObjects: @11, @2, @32, @33, @-5, @-3, @-1, @0, @10, nil];

		//used this: https://en.wikipedia.org/wiki/Longest_increasing_subsequence#Efficient_algorithms
		NSArray *sortedArray = [SampleLineClass longestIncreasingSubsequenceArray:arrayOfNumbers];

		//Output the results of calculations
		NSString *strOutPut = @"";
		for(int indx = 0; indx < [sortedArray count]; indx++) {
				strOutPut = [strOutPut stringByAppendingFormat: @"%@'%d'" ,
										 ([strOutPut length] > 0 ? @", ": @" "), [sortedArray[indx] intValue]];
		}

		NSLog(@ "Maximal length of array's sequence has %d elements: %@", (int)[sortedArray count], strOutPut);
}

+ (int) ceilIndex: (NSMutableArray*)A l:(int)l r:(int)r key:(int)key {
		while (r - l > 1) {
				int m = l + (r - l)/2;
				if ((int)A[m]>=key)
						r = m;
				else
						l = m;
		}
		return r;
}

+ (NSArray*) longestIncreasingSubsequenceArray: (NSArray*)A {
		// Add boundary case, when array size is one

		int size = (int)[A count];
		NSMutableArray *tailTable = [NSMutableArray new];
		int len; // always points empty slot

		tailTable[0] = A[0];
		len = 1;
		for (int i = 1; i < size; i++)
		{
				if ((int)A[i] < (int)tailTable[0]) {
						// new smallest value
						tailTable[0] = A[i];

				} else if ((int)A[i] > (int)tailTable[len-1]) {
						// A[i] wants to extend largest subsequence
						tailTable[len++] = A[i];

				} else {

						int indx = [SampleLineClass ceilIndex: tailTable l:-1 r:len-1 key:(int)A[i]];
						tailTable [indx] = A[i];
				}
		}

		return tailTable;
}

//MARK: - helper

+ (NSString *) removeSpecialSymbolsInTheLine: (NSString *)line {
		//remove special symbols
		NSArray *specSymb = [NSArray arrayWithObjects:@".", @";", @":", @",", nil];
		int idx = 0;
		while (idx < [specSymb count]) {
				line = [line stringByReplacingOccurrencesOfString: specSymb[idx] withString:@""];
				idx++;
		}

		return line;
}

+ (NSArray*) getFilteredArrayWithPredicate: (NSString*)strPredicate
															arrayForWork:(NSArray*)arrayWork {

		static NSArray *arrayForReturn;

		NSPredicate *predicate = [NSPredicate predicateWithFormat:strPredicate, 0];
		NSArray *filteredarr = [NSMutableArray arrayWithArray:[arrayWork filteredArrayUsingPredicate:predicate]];
		arrayForReturn = filteredarr;

		return arrayForReturn;
}

+ (NSString*) formatingStr: (NSString*)str
							arrayForWork:(NSArray*)arrayWork {

		NSString *countOfElements = [NSString stringWithFormat:@"%lu",(unsigned long)[arrayWork count]];
		NSString *strCalcValue = [NSString stringWithFormat: str, countOfElements];

		return strCalcValue;
}


@end


//MARK: - init

int main(int argc, const char * argv[]) {
		@autoreleasepool {
				// insert code here...
				SampleLineClass *sampleClass = [SampleLineClass new];

				//#lines
				//#1 - lines
				[sampleClass calculateTheMinimumAndMaximumNumberOfCharactersPerLine];

				//#2 - lines
				[sampleClass calculateHowManyDifferentSymbolsOccursOnLine];

				//#3 - lines
				[sampleClass findTheWordThatBeginsAndEndsWithTheSameLetter];

				//#4 - lines
				[sampleClass findTheAmountOfAvailableNumbersInTheText];

				//#5 - lines
				[sampleClass checkWhetherItIsPossibleToReadTheSameWordInTwoDirections];

				//#6 - lines
				[sampleClass implementTheCodeSandwich];

				//#arrays
				//#1 - arrays
				[sampleClass countTheNumberOfPositiveNegativeZeroElementsInTheArray];
				
				//#2 - arrays
				[sampleClass swapTheLargestAndSmallestElementsInTheArray];
				
				//#3 - arrays
				[sampleClass increasingSequenceOfMaximalLengthInArray];
				
		}
		
		return 0;
}
