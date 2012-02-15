
var PageName = 'Home';
var PageId = 'fc2d94d28b2e4bf3b43d422f209e0191'
var PageUrl = 'Home.html'
document.title = 'Home';
var PageNotes = 
{
"pageName":"Home",
"showNotesNames":"False"}
var $OnLoadVariable = '';

var $NewVariable1 = '';

var $CSUM;

var hasQuery = false;
var query = window.location.hash.substring(1);
if (query.length > 0) hasQuery = true;
var vars = query.split("&");
for (var i = 0; i < vars.length; i++) {
    var pair = vars[i].split("=");
    if (pair[0].length > 0) eval("$" + pair[0] + " = decodeURIComponent(pair[1]);");
} 

if (hasQuery && $CSUM != 1) {
alert('Prototype Warning: The variable values were too long to pass to this page.\nIf you are using IE, using Firefox will support more data.');
}

function GetQuerystring() {
    return '#OnLoadVariable=' + encodeURIComponent($OnLoadVariable) + '&NewVariable1=' + encodeURIComponent($NewVariable1) + '&CSUM=1';
}

function PopulateVariables(value) {
    var d = new Date();
  value = value.replace(/\[\[OnLoadVariable\]\]/g, $OnLoadVariable);
  value = value.replace(/\[\[NewVariable1\]\]/g, $NewVariable1);
  value = value.replace(/\[\[PageName\]\]/g, PageName);
  value = value.replace(/\[\[GenDay\]\]/g, '11');
  value = value.replace(/\[\[GenMonth\]\]/g, '1');
  value = value.replace(/\[\[GenMonthName\]\]/g, 'January');
  value = value.replace(/\[\[GenDayOfWeek\]\]/g, 'Wednesday');
  value = value.replace(/\[\[GenYear\]\]/g, '2012');
  value = value.replace(/\[\[Day\]\]/g, d.getDate());
  value = value.replace(/\[\[Month\]\]/g, d.getMonth() + 1);
  value = value.replace(/\[\[MonthName\]\]/g, GetMonthString(d.getMonth()));
  value = value.replace(/\[\[DayOfWeek\]\]/g, GetDayString(d.getDay()));
  value = value.replace(/\[\[Year\]\]/g, d.getFullYear());
  return value;
}

function OnLoad(e) {

}

var u20 = document.getElementById('u20');

var u21 = document.getElementById('u21');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u21ann'), "<div id='u21Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u21Note').click(function(e) { ToggleWorkflow(e, 'u21', 300, 150, false); return false; });
var u21Ann = 
{
"label":"email address",
"Description":"User types in his email address",
"Effort":"has to be in correct format"};

if (bIE) u21.attachEvent("onfocus", Focusu21);
else u21.addEventListener("focus", Focusu21, true);
function Focusu21(e)
{
windowEvent = e;


if ((GetWidgetFormText('u21')) == ('email@address.com')) {

SetWidgetFormText('u21', '');

}

}

if (bIE) u21.attachEvent("onblur", LostFocusu21);
else u21.addEventListener("blur", LostFocusu21, true);
function LostFocusu21(e)
{
windowEvent = e;


if ((GetWidgetFormText('u21')) == ('')) {

SetWidgetFormText('u21', 'email@address.com');

}

}

var u22 = document.getElementById('u22');
gv_vAlignTable['u22'] = 'top';
var u23 = document.getElementById('u23');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u23ann'), "<div id='u23Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u23Note').click(function(e) { ToggleWorkflow(e, 'u23', 300, 150, false); return false; });
var u23Ann = 
{
"label":"Go button",
"Description":"Validates the headline ",
"Effort":"links to the next frame (fade)"};

u23.style.cursor = 'pointer';
if (bIE) u23.attachEvent("onclick", Clicku23);
else u23.addEventListener("click", Clicku23, true);
function Clicku23(e)
{
windowEvent = e;


if (true) {

	SetPanelState('u5', 'pd1u5','none','',500,'fade','',500);

}

}

var u24 = document.getElementById('u24');
gv_vAlignTable['u24'] = 'top';
var u25 = document.getElementById('u25');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u25ann'), "<div id='u25Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u25Note').click(function(e) { ToggleWorkflow(e, 'u25', 300, 150, false); return false; });
var u25Ann = 
{
"label":"username",
"Description":"User can type in his username",
"Effort":"by default, a username is generated, (according to the IP address?)<BR>Username has to be cecked if does not already exist on the database"};

if (bIE) u25.attachEvent("onfocus", Focusu25);
else u25.addEventListener("focus", Focusu25, true);
function Focusu25(e)
{
windowEvent = e;


if ((GetWidgetFormText('u25')) == ('Anonymous1')) {

SetWidgetFormText('u25', '');

	SetPanelVisibility('u26','','fade',500);

}

}

if (bIE) u25.attachEvent("onblur", LostFocusu25);
else u25.addEventListener("blur", LostFocusu25, true);
function LostFocusu25(e)
{
windowEvent = e;


if ((GetWidgetFormText('u25')) == ('')) {

SetWidgetFormText('u25', 'Anonymous1');

}

}

var u26 = document.getElementById('u26');

var u27 = document.getElementById('u27');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u27ann'), "<div id='u27Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u27Note').click(function(e) { ToggleWorkflow(e, 'u27', 300, 150, false); return false; });
var u27Ann = 
{
"label":"Go button",
"Description":"Validates the headline ",
"Effort":"links to the next frame (fade)"};

u27.style.cursor = 'pointer';
if (bIE) u27.attachEvent("onclick", Clicku27);
else u27.addEventListener("click", Clicku27, true);
function Clicku27(e)
{
windowEvent = e;


if (true) {

	SetPanelState('u5', 'pd1u5','none','',500,'fade','',500);

}

}

var u28 = document.getElementById('u28');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u28ann'), "<div id='u28Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u28Note').click(function(e) { ToggleWorkflow(e, 'u28', 300, 150, false); return false; });
var u28Ann = 
{
"label":"password",
"Description":"User can type in his password",
"Effort":"verification of strength"};

if (bIE) u28.attachEvent("onfocus", Focusu28);
else u28.addEventListener("focus", Focusu28, true);
function Focusu28(e)
{
windowEvent = e;


if ((GetWidgetFormText('u28')) == ('Username')) {

SetWidgetFormText('u28', '');

}

}

if (bIE) u28.attachEvent("onblur", LostFocusu28);
else u28.addEventListener("blur", LostFocusu28, true);
function LostFocusu28(e)
{
windowEvent = e;


if ((GetWidgetFormText('u28')) == ('')) {

SetWidgetFormText('u28', 'Username');

}

}

var u29 = document.getElementById('u29');

var u30 = document.getElementById('u30');
gv_vAlignTable['u30'] = 'center';
var u31 = document.getElementById('u31');

var u32 = document.getElementById('u32');

var u33 = document.getElementById('u33');
gv_vAlignTable['u33'] = 'center';
var u34 = document.getElementById('u34');
gv_vAlignTable['u34'] = 'top';
var u0 = document.getElementById('u0');
gv_vAlignTable['u0'] = 'top';
var u1 = document.getElementById('u1');

var u2 = document.getElementById('u2');

var u3 = document.getElementById('u3');

var u4 = document.getElementById('u4');

var u5 = document.getElementById('u5');

var u6 = document.getElementById('u6');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u6ann'), "<div id='u6Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u6Note').click(function(e) { ToggleWorkflow(e, 'u6', 300, 150, false); return false; });
var u6Ann = 
{
"label":"Trends rating",
"Description":"an algorithm will establish if you are"};

var u7 = document.getElementById('u7');
gv_vAlignTable['u7'] = 'top';
var u8 = document.getElementById('u8');
gv_vAlignTable['u8'] = 'top';
var u9 = document.getElementById('u9');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u9ann'), "<div id='u9Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u9Note').click(function(e) { ToggleWorkflow(e, 'u9', 300, 150, false); return false; });
var u9Ann = 
{
"label":"Simulation",
"Description":"Picture of a fake Evening Standard Issue featuring the title chosen by User"};

var u10 = document.getElementById('u10');
gv_vAlignTable['u10'] = 'center';
var u11 = document.getElementById('u11');
gv_vAlignTable['u11'] = 'top';
var u12 = document.getElementById('u12');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u12ann'), "<div id='u12Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u12Note').click(function(e) { ToggleWorkflow(e, 'u12', 300, 150, false); return false; });
var u12Ann = 
{
"label":"call",
"Description":"call to action Sharing"};
gv_vAlignTable['u12'] = 'top';
var u13 = document.getElementById('u13');

u13.style.cursor = 'pointer';
if (bIE) u13.attachEvent("onclick", Clicku13);
else u13.addEventListener("click", Clicku13, true);
function Clicku13(e)
{
windowEvent = e;


if (true) {

	SetPanelState('u5', 'pd2u5','none','',500,'fade','',500);

}

}

var u14 = document.getElementById('u14');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u14ann'), "<div id='u14Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u14Note').click(function(e) { ToggleWorkflow(e, 'u14', 300, 150, false); return false; });
var u14Ann = 
{
"label":"twitter button",
"Description":"triggers the twitter connect pop out"};

var u15 = document.getElementById('u15');
gv_vAlignTable['u15'] = 'center';
var u16 = document.getElementById('u16');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u16ann'), "<div id='u16Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u16Note').click(function(e) { ToggleWorkflow(e, 'u16', 300, 150, false); return false; });
var u16Ann = 
{
"label":"facebook button",
"Description":"triggers th efacebook connect pop out"};

var u17 = document.getElementById('u17');
gv_vAlignTable['u17'] = 'center';
var u18 = document.getElementById('u18');
gv_vAlignTable['u18'] = 'top';
var u19 = document.getElementById('u19');

x = 0;
y = 0;
InsertAfterBegin(document.getElementById('u19ann'), "<div id='u19Note' class='annnoteimage' style='left:" + x + ";top:" + y + "'></div>");
$('#u19Note').click(function(e) { ToggleWorkflow(e, 'u19', 300, 150, false); return false; });
var u19Ann = 
{
"label":"Headline",
"Description":"User can type in his guess for tomorrow's Evening Standard headline",
"Effort":"Submissions are limited in time. As soon as the headlines have been chosen and printed, The text fields strarts accepting submissions for the next day."};

if (bIE) u19.attachEvent("onfocus", Focusu19);
else u19.addEventListener("focus", Focusu19, true);
function Focusu19(e)
{
windowEvent = e;


if ((GetWidgetFormText('u19')) == ('ENTER YOUR HEADLINE HERE...')) {

SetWidgetFormText('u19', '');

	SetPanelVisibility('u20','','fade',500);

}

}

if (bIE) u19.attachEvent("onblur", LostFocusu19);
else u19.addEventListener("blur", LostFocusu19, true);
function LostFocusu19(e)
{
windowEvent = e;


if ((GetWidgetFormText('u19')) == ('')) {

SetWidgetFormText('u19', 'ENTER YOUR HEADLINE HERE...');

}

}

if (window.OnLoad) OnLoad();
