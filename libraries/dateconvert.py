from datetime import datetime

def mdy_to_ymd(d):
    return datetime.strptime(d, '%b %d, %Y').strftime('%m/%d/%Y')