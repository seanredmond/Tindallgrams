---
layout: tindallgram
date: Jan 07 1970
from: PA/Chief, Apollo Data Priority Coordination
serial: 70-PA-T-1A
subject: Important LM computer program change for Apollo 13 descent
---
There were some things about the terminal descent on the last mission that kind
of spooked a lot of people. One of the things suggested as a result of this was
to add a capability to the LM guidance and control system which would assist the
crew during the last 100 feet or so of the descent. Specifically, fix the PGNCS
so that it will provide an automatic nulling of the horizontal velocity while
the crew controls the descent rate with the ROD switch. This memo is to inform
you that we are adding this capability to the system for the next flight -
Apollo 13 - and to describe briefly just what it is we are doing.

A modification is being made to P66 which will eliminate P65 or, if you like,
replace it with a similar but superior capability. We are retaining the current
P66 mode of operation exactly but are adding the following feature to it. If the
crew switches from "Attitude Hold" to "Auto" the PGNCS will null horizontal
velocity to zero - both fore/aft and lateral. It does this, of course, just as
the crew would in the manual mode by controlling the spacecraft attitude. There
is no restriction for switching back and forth between "Attitude Hold" and
"Auto" in P66 as often as the crew desires.

It is anticipated that the crew would fly the descent to an altitude of about
100 feet exactly as has been done on both previous missions - that is, they will
exit P64 and go into P66 (Att. Hold) and manually control rate of descent and
attitude to place the spacecraft over the desired touchdown point with small
horizontal velocity remaining (say about 3 fps and certainly not more than 10
fps). At this point they can switch to Auto which would cause the PGNCS to take
over attitude control to get and maintain the horizontal velocity as near zero
as it is able, leaving the crew free to monitor their systems, watch out the
windows, control the rate of descent, etc. MIT also fixed the system so that the
attitude errors are always displayed on the FDAI "error" needles in P66 so the
crew will know what the PGNCS plans to do when they enable it.

Since there is no programmed constraint keeping the crew from switching to Auto
when the horizontal velocities are quite large, spacecraft attitude limits have
been programmed to insure that the LM does not suddenly pitch or yaw to an
extreme attitude in an attempt to kill off these velocities, if the crew were to
select Auto under those conditions. This limit is in erasable memory and is
currently set at 20°.

An associated feature we are implementing is the inhibiting of the landing radar
data at about the same point in order to insure that spurious velocity data does
not cause undesirable attitude or translational transients.

Since there is no apparent reason P65 would ever be preferred to the new Auto
P66, the PGNCS logic is being fixed so that if the P64 target conditions are met
prior to the crew taking over in P66, the automatic program switching from P64
will be to P66 Auto rather than P65. Thus, with this change and the one
previously implemented so that the PGNCS ignores the throttle mode switch
position, we have essentially eliminated both P65 and P67, and have remaining
two modes of operation in P66. Most experts involved seem to feel that if we had
been clairvoyant the programs would have been implemented this way in the first
place.

One final word, this program change was not seriously considered until December
12 at which time a group of us got together here and pinned down specific
functional requirements which we then discussed over the phone with MIT's Russ
Larson and Allan Klumpp. It was interesting to note that they had also thought
about this and had arrived at almost exactly the same conclusions. At our
request they set about implementing this change in an orderly but expeditious
way, resulting in an offline assembly delivered to MSC at the break of dawn on
December 23. Gene Cernan and Pete Conrad exercised it in the LMS that day and
proclaimed it to be outstanding. Jim Lovell has also played with it at the Cape
and is said to have expressed his pleasure and burning desire for it. MIT, in
the meantime, has completed their detailed reverification of the program. GAC's
Clint Tillman has also exercised it on their simulator and John Norton has
reviewed the actual coding and I am told declared it to be a work of art. In
other words, although we are messing with absolutely the most critical part of
the most critical phase of the mission, we are confident that the change has
been made correctly and are releasing the tape to Raytheon to make the new
Module 5 rope to be delivered to KSC before CDDT.

Although I'm certain there are others, I personally know that a large dose of
special credit should go to Allan Klumpp and Tom Price for getting this job done
so well and so quickly!
