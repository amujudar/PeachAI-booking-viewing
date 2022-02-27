// Import the commonReactions library so that you don't have to worry about coding the pre-programmed replies
import "commonReactions/all.dsl";

context
{
// Declare the input variable - phone. It's your hotel room phone number and it will be used at the start of the conversation.  
    input phone: string;
    output new_time: string="";
    output new_day: string="";
}

// A start node that always has to be written out. Here we declare actions to be performed in the node. 
start node root
{
    do
    {
        #connectSafe($phone); // Establishing a safe connection to the hotel room's phone.
        #waitForSpeech(1000); // Waiting for 1 second to say the welcome message or to let the hotel guest say something
        #sayText("Hi, my name is Peach, I'm calling in regard to your Rental application for the apartment 975 academy way with land lord Samir. Is this an appropriate time to talk?"); // Welcome message
        wait *; // Wating for the hotel guest to reply
    }
    transitions // Here you give directions to which nodes the conversation will go
    {
        will_call_back: goto will_call_back on #messageHasIntent("no");
        interview_day: goto interview_day on #messageHasIntent("yes");
    }
}

node will_call_back
{
    do
    {
        #sayText("No worries, what day may I call you back ?");
        wait *;
    }
    transitions
    {
        call_bye: goto call_bye on #messageHasData("day_of_week");
    }
}

node call_bye
{
    do
    {
        set $new_day =  #messageGetData("day_of_week")[0]?.value??"";
        #sayText("Got it, I'll call you back on " + $new_day + ". What hour can I call you back " + $new_day + " ?");
        wait*;
    }
    transitions
    {
        call_bye2: goto call_bye2 on #messageHasData("time");
    }
}

node call_bye2
{
    do
    {
        set $new_time = #messageGetData("time")[0]?.value??"";
        #sayText("Got it, I will call you back on "+ $new_day + $new_time + ".Looking forward to speaking to you soon. Have a nice day!");
        exit;
    }
}


node interview_day
{
    do
    {
        #sayText("Thank you very much for your replies. At this point I would like to invite you to an in-person Viewing of the property. What day would work best for you?");
        wait *;
    }
    transitions 
    {
       confirm_day: goto confirm_day on #messageHasData("day_of_week");
    }
    onexit
    {
        confirm_day: do 
        {
        set $new_day = #messageGetData("day_of_week")[0]?.value??"";
        }
    }
}

node confirm_day
{ 
    do 
    { 
        #sayText($new_day + ", you say?");
        wait *;
    }
        transitions
    {
        interview_time: goto interview_time on #messageHasIntent("yes");
        repeat_day: goto repeat_day on #messageHasIntent("no");
    }
}

node repeat_day
{
    do 
    {
        #sayText("Sorry about that, what day would you be able to come for the interview?");
        wait *;
    }
    transitions 
    {
       confirm_day: goto confirm_day on #messageHasData("day_of_week");
    }
    onexit
    {
        confirm_day: do {
        set $new_day = #messageGetData("day_of_week")[0]?.value??"";
       }
    }
}

node interview_time
{
    do
    {
        #sayText("Uh-huh, fantastic. And what hour works best for you?");
        wait *;
    }
    transitions 
    {
       confirm_time: goto confirm_time on #messageHasData("time");
    }
    onexit
    {
        confirm_time: do {
        set $new_time = #messageGetData("time")[0]?.value??"";
        }
    }
}

node confirm_time
{ 
    do 
    { 
        #sayText("You said " + $new_time + ", is that right?");
        wait *;
    }
    transitions
    {
        end_interview: goto end_interview on #messageHasIntent("yes");
        repeat_time: goto repeat_time on #messageHasIntent("no");
    }
}

node repeat_time
{
    do 
    {
        #sayText("Let's do it one more time. What hour can you come for the interview?");
        wait *;
    }
    transitions 
    {
       confirm_time: goto confirm_time on #messageHasData("time");
    }
    onexit
    {
        confirm_time: do {
        set $new_time = #messageGetData("time")[0]?.value??"";
       }
    }
}

node end_interview 
{
    do
    {
        #sayText("Wonderful! Um... This concludes our call, I will relay your replies to the land lord. Have a fantastic rest of the day. Bye!");
        exit;
    }
}











