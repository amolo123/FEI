class TestEnv:
    ip = '123.4.5.6'
    user = 'robot'
    roles = ['admin', 'user']


STEIL_EN = {'amountEndorsements':'3','list':["Additional Insured","Additional Scheduled Location(s)","Additional Scheduled Storage Tanks"]}

STEIL_VA = {'amountEndorsements':'7','list':["OFAC","Trade or Economic Sanctions Endorsement","Service of Suit","Minimum Earned Premium Endorsement","No Coverage for Electronic Data","Financial Assurance Amendatory Endorsement","Claims Notice Document"]}



# NY = {'amountEndorsements': '55',
#               'list': ['List','variable']}
# LA = {'amountEndorsements': '10',
#               'list': ['List','variable']}
# SF = {'amountEndorsements': '45',
#               'list': ['List','variable']}

def get_variables(env):
    if env == 'STEIL_EN':
        return STEIL_EN  
    elif env == 'STEIL_VA':
        return STEIL_VA     
    else:
        # default variables
        return STEIL_EN