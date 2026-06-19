*** Settings ***
Library            OperatingSystem
Library            Collections
Library            QForce
Library            ${CURDIR}/../libraries/graph.py

*** Variables ***
${client_id_mail}        # Initialize these variables in Copado Robotic Testing test suite variables
${client_secret_mail}    # and remember to crypt and hide.
${tenant_id}
${email_address}
${email_subject}
${email_body}