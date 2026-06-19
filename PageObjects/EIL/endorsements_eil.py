class TestEnv:
    ip = '123.4.5.6'
    user = 'robot'
    roles = ['admin', 'user']

EIL_VA = {
    'amountEndorsements': '29',
    'list': [
        "Common Policy Conditions",
        "Nuclear Energy Liability Exclusion",
        "Deductible Liability Insurance Endorsement",
        "Minimum Earned Premium Endorsement",
        "Automatic Additional Insured Owners Lessees or Contractors",
        "Automatic Waiver of Subrogation",
        "Transportation at Jobsite Endorsement",
        "Exclusion - Access or Disclosure of Data",
        "OFAC",
        "Trade or Economic Sanctions Endorsement",
        "Virus or Bacteria Exclusion - CGL",
        "Virus or Bacteria Exclusion - CPL",
        "Virus or Bacteria Exclusion - PL",
        "Exclusion - Violation of Statutes that Govern E-Mails, Fax, Phone Calls",
        "Exclusion - Engineers, Architects or Surveyors",
        "Claims Notice Document",
        "Service of Suit",
        "Claims Notice Document",
        "No Coverage for Electronic Data",
        "Mold-Legionella Exclusion Endorsement",
        "PFAS Exclusion Endorsement",
        "Common Policy Conditions Endorsement",
        "Nuclear Energy Liability Exclusion",
        "Mold and Mildew Exclusion",
        "Minimum Premium Endorsement",
        "Employment Discrimination & Employment-Related Practices Exclusion",
        "Claims Notice Document",
        "Service of Suit",
        "PFAS Exclusion Endorsement"
    ]
}


def get_variables(env):
    if env == 'EIL_EN':
        return EIL_EN        
    elif env == 'EIL_VA':
        return EIL_VA
    else:
        # default variables
        return EIL_EN