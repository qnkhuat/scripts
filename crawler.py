import requests
import json


class Subreddit(object):
    def __init__(self,url):
        self.url = url
        self._get_meta_data()
        self.check_content()


    def _get_meta_data(self):
        url = self.url+'/.json'
        data = json.loads(requests.get(url,headers = {'User-agent': 'your bot 0.1'}).content)
        thread = data[0]['data']['children'][0]['data']

        # thread infos
        self.score = thread['score']
        self.title = thread['title']
        self.selftext = thread['selftext']
        self.fulltext = [self.title,self.selftext]


        # comments
        comments_obj = data[1]['data']['children']
        self.comments = self.get_comments(comments_obj)
        

    def get_comments(self,comments):
        """ Extract comments from reddit comments object"""
        all_comments = []
        for comment in comments:
            try :
                all_comments.append({
                    'comment':comment['data']['body'],
                    'score':comment['data']['score']
                })
            except: pass
        return all_comments
    
    def check_content(self):
        self.is_removed =  self.selftext == '[removed]' or self.title == '[removed]'
        
    
    def to_dict(self):
        return {
            'comments':self.comments,
            'score':self.score,
            'title':self.title,
            'selftext':self.selftext,
            'fulltext':self.fulltext,
            'url':self.url,
            'is_removed':self.is_removed,
        }

    
