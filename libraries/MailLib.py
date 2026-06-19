from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn

import asyncio #pip3 install asyncio

#pip3 install msgraph-sdk
from azure.identity import ClientSecretCredential
from msgraph import GraphServiceClient
from msgraph.generated.users.item.send_mail.send_mail_post_request_body import SendMailPostRequestBody
from msgraph.generated.models.body_type import BodyType
from msgraph.generated.models.message import Message
from msgraph.generated.models.email_address import EmailAddress
from msgraph.generated.models.importance import Importance
from msgraph.generated.models.item_body import ItemBody
from msgraph.generated.models.recipient import Recipient
from msgraph.generated.users.item.messages.messages_request_builder import MessagesRequestBuilder

#pip3 install beautifulsoup4 lxml
from bs4 import BeautifulSoup

import urllib.parse

__version__ = '1.0.0'

class MailLib(object):

    ROBOT_LIBRARY_VERSION = __version__
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self, tenant_id, client_id_mail, client_secret_mail):
        self.tenant_id = tenant_id
        self.client_id_mail = client_id_mail
        self.client_secret_mail = client_secret_mail

        credential = ClientSecretCredential(
            tenant_id,
            client_id_mail,
            client_secret_mail,
        )

        scopes = ['https://graph.microsoft.com/.default']

        self.client = GraphServiceClient(credentials=credential, scopes=scopes)

    async def get_user_messages(self,userid):
        messages = await (self.client.users.by_user_id(userid).messages.get())
        if messages and messages.value:
            for msg in messages.value:
                print(msg.subject, msg.id, msg.from_, msg.body)
        return messages

    async def get_user_links_in_messages(self,userid):
        links = []
        messages = await (self.client.users.by_user_id(userid).messages.get())
        if messages and messages.value:
            for msg in messages.value:
                html = msg.body.content
                # print(html)
                soup = BeautifulSoup(html, features='lxml')
                for link in soup.findAll('a'):
                    # print(link.get('href'))
                    
                    links.append(urllib.parse.unquote(link.get('href')))
        
        print(links)
        return links

    async def get_last_user_message(self, userid):
        query_params = MessagesRequestBuilder.MessagesRequestBuilderGetQueryParameters(
            select=['subject', 'from', 'body'], skip = 0, top=1
        )
        request_config = MessagesRequestBuilder.MessagesRequestBuilderGetRequestConfiguration(
            query_parameters=query_params
        )

        messages = await (self.client.users.by_user_id(userid).messages.get(request_configuration=request_config))
        if messages and messages.value:
            for msg in messages.value:
                print(msg.subject)
                logger.info(msg.subject)
        return messages

    async def send_mail(self, userid, senderName, destinationMailAddress, destinationMailName, MailSubject, MailBody):
        try:
            sender = EmailAddress()
            sender.address = userid
            sender.name = senderName
                
            from_recipient = Recipient()
            from_recipient.email_address = sender
            recipients = []

            recipient_email = EmailAddress()
            recipient_email.address = destinationMailAddress
            recipient_email.name = destinationMailName
                
            to_recipient = Recipient()
            to_recipient.email_address = recipient_email
            recipients.append(to_recipient) 

            email_body = ItemBody()
            email_body.content = MailBody
            email_body.content_type = BodyType.Text
                
            message = Message()
            message.subject = MailSubject
            message.from_escaped = from_recipient
            message.to_recipients = recipients
            message.body = email_body
                
            request_body = SendMailPostRequestBody()
            request_body.message = message
            response = await self.client.users.by_user_id(userid).send_mail.post(request_body)
        except Exception as e:
            print("An exception occurred") 
            print(e)

    def get_loop(self):
        try:
            loop = asyncio.get_event_loop()
        except RuntimeError:
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
        return loop

    def get_last_mail(self, userid):
        messages = self.get_loop().run_until_complete(self.get_last_user_message(userid))
        return messages

    def get_all_mail(self, userid):
        messages = self.get_loop().run_until_complete(self.get_user_messages(userid))
        return messages

    def get_mail_links(self, userid):
        links = self.get_loop().run_until_complete(self.get_user_links_in_messages(userid))
        return links

    def send_mail_message(self, userid, senderName, destinationMailAddress, destinationMailName, MailSubject, MailBody):
        self.get_loop().run_until_complete(self.send_mail(userid, senderName, destinationMailAddress, destinationMailName, MailSubject, MailBody))

