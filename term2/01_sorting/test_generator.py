#!/usr/bin/python

from datetime import datetime, timedelta
from random import randrange

length = [10, 20, 50, 100]
types = ['asc', 'desc', 'both', 'random1', 'random2']


def random_date(start, end):
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = randrange(int_delta)
    return start + timedelta(seconds=random_second)


def get_random_date_set(l):
    d1 = datetime.strptime('01.01.1900', '%d.%m.%Y')
    d2 = datetime.strptime('01.01.2000', '%d.%m.%Y')
    date_list = []
    for i in range(0, l):
        date_list.append(random_date(d1, d2))
    return date_list


for t in types:
    for l in length:
        f = open('./data/{0}_{1}.txt'.format(t, l), 'w')
        lst = get_random_date_set(l)
        if t == 'asc':
            lst.sort()
        elif t == 'desc':
            lst.sort()
            lst.reverse()
        elif t == 'both':
            lst.sort()
            lst_desc = lst[1::2]
            lst_desc.reverse()
            lst[1::2] = lst_desc
        for d in lst:
            f.write(d.strftime('%d.%m.%y') + '\r\n')
