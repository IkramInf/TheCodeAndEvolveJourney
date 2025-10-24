# Concurrency
(1114. Print in Order)[https://leetcode.com/problems/print-in-order/]
```
from threading import Semaphore

class Foo:
    def __init__(self):
        self.sem_second = Semaphore(0)
        self.sem_third = Semaphore(0)

    def first(self, printFirst: 'Callable[[], None]') -> None:
        
        # printFirst() outputs "first". Do not change or remove this line.
        printFirst()
        self.sem_second.release()

    def second(self, printSecond: 'Callable[[], None]') -> None:
        self.sem_second.acquire()
        # printSecond() outputs "second". Do not change or remove this line.
        printSecond()
        self.sem_third.release()

    def third(self, printThird: 'Callable[[], None]') -> None:
        self.sem_third.acquire()
        # printThird() outputs "third". Do not change or remove this line.
        printThird()
```
