import requests
import os,json
from os.path import join as pjoin
import argparse,arrow
from urllib.parse import urljoin

from crawler import Subreddit

parser = argparse.ArgumentParser()


# URL setting
parser.add_argument('--base_url',help='The url source',default='https://api.pushshift.io/reddit/search/')
parser.add_argument('-t',help='Type of content to crawl comment|submission',default='submission')

parser.add_argument('-o',help='Output folder',default='./data')

parser.add_argument('-s',help='Subreddit',type=str,default='jokes')
parser.add_argument('--st',help='Score threshold',type=int,default=100)
parser.add_argument('--interval',help='Day interval for crawling',type=int,default=1)
parser.add_argument('--days',help='How many days to the past to crawl',type=int,default=365)


args = parser.parse_args()


assert args.t in ['submission','comment'], 'Incorrect type'


# get current time
now = arrow.utcnow()

# create dir

end_day = now.format('DD-MM-YY')
start_day = arrow.get(now.timestamp - 86400*args.days).format('DD-MM-YY')

print('Crawlling')
print(f'From {start_day} to {end_day} - {args.days} days')
print(f'Interval={args.interval} with score =>{args.st}')
print('='*20)

output_folder = pjoin(args.o,
        ('_').join([args.s,start_day,end_day,'interval',str(args.interval),'st',str(args.st)])
        )
os.makedirs(output_folder,exist_ok=True)



QUERY_URL = urljoin(args.base_url,args.t) 


total_threads = 0

for day in range(args.interval,args.days,args.interval):
    payload = {
            'after':str(day)+'d',
            'before':str(day-args.interval) + 'd',
            'size':500,
            'sort_type':'score',
            'is_video':'false',
            #'score':'>'+args.st,
            # the score from pushshift sometimes a little bit not up to date with
            # not popular threads, we can lost a lot of good threads there
            # so we get almost all threads and send user Subreddit to find it
            # real score
            'score':'>0',
            'subreddit':args.s,
            'sort':'desc',
            #'fields':"title,score,selftext,url,created_utc,num_comments",
            }
    res = requests.get(QUERY_URL,params=payload)

    data_pushshift = json.loads(res.content)

    # format date
    start_day = arrow.get(now.timestamp - 86400*(day-args.interval)).format('DD-MM-YY')
    end_day= arrow.get(now.timestamp - 86400*day).format('DD-MM-YY')
    print(f'Start day :{start_day}')
    print(f'End day :{end_day}')
    print(f"{len(data_pushshift['data'])} threads found")

    
    total_threads  += len(data_pushshift['data'])

    data = []
    for thread in data_pushshift['data']:
        subreddit = Subreddit(thread['full_link'])
        if subreddit.score > args.st:
            data.append(subreddit.to_dict())

    if len(data)>0 : 
        file_name = ('_').join([start_day,end_day,str(len(data))]) + '.json'
        with open(pjoin(output_folder,file_name), 'w') as outfile:
            json.dump(data, outfile)
    
    print(f"Saved {len(data)} threads")
    print('-'*20)



print('Crawl stopped')
print(f'{total_threads} threads crawled')




