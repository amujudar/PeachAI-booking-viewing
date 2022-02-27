# Peach AI: Book Viewing. Place to book a viewing with your landlord.


1. Clone the repo and install the dependencies:

```sh
npm install
```

2. Create or log into your account using the Dasha CLI tool:

```sh
npx dasha account login
```

3. To start a text chat, run:

```sh
npm start chat
```

4. To receive a phone call from Dasha, run:

```sh
npm start <your phone number>
```

**How to gain access your personalized Twilio phone number**
1. Sign up to your Twilio account 
2. Use your Twilio API and log into your console 
3. Set up your sip trunk 
4. Go to tab `Numbers`
5. Copy your Twilio number to sip trunk
6. Go to tab `Termination`
7. Write `Termination URI`, Such as, `My-Peach-AI-app.pstn.twilio.com`
8. Add credentials for auth with `Username` = `Phone number` you want to use, and some password

