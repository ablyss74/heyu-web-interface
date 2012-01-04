#! /usr/bin/env python
# Author: 	Kris Beazley
# Apache License, Version 2.0 http://www.apache.org/licenses/LICENSE-2.0


def crontab(data):
    
    print("""
            <table><tr><td><table class=control_panel><tr>
		    <tr>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd1}')\">cmd 1</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd2}')\">cmd 2</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd3}')\">cmd 3</button>
		    <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd4}')\">cmd 4</button>
	        <td><button type=button class=userconfigbutton onclick=\"Status(); show('control_panel_@{crontab}@{cmd5}')\">cmd 5</button>
		    </table>
            """)
    if 'cmd' in data:
        print "This is", data, "outside the textarea"
   
    print("""<table><tr><td><br>
            <textarea name=control_panel_save>""")
    if 'cmd' in data:
        print "This is", data, "inside the textarea"
        
    print "</textarea></table></form>"



