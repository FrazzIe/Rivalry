Heres my delivery van script. I know the code isn't that clean and that it probally could be done more efficiently in a lot of ways, but as my name sugests. I am a noob coder.

Delivery script:
You will make runs to about 400 handpicked locations. 
The script chooses one at random and you can deliver multiple packages with the same truck. (Amount can be altered)
After wich you need to return to the depot to restock the van or get a new one. 

Multiple runs with the same van: you can alter this in line 583

Requirements: 
-MissionText (it looks nice)
-Essentialmode (only for the payments, you can replace this easy with your own payment system. (See serverside lua) 
-Job mode (Serverside validates if you have the correct job to start van runs)

Installation: 
Copy the delivery map to your resources and add it to citmp-server.yml
Make a database entry in jobs system. (Add the jobname & an ID of your choice to the database)

As an example from my database: 

job_id	job_name	salary
12	Delivery guy	100