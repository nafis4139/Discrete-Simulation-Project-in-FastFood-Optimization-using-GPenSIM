function  [EIP] = add_to_events_queue(NEIQ, EIP)
% [EIP] = add_to_events_queue(NEIQ, EIP)
%
% Name:	add_to_events_queue
% Description:	Adds a new firing event to event_in_progress queue (EIP).
% The events are sorted in the queue according to their completion time
% Input parameters:	
%               PN: Runtime Petri net structure 
%               NEIQ : the new event in progress
%               EIP: Queue off firing events
%
% Out parameters:	EIP: Queue off firing events that includes the new one
% Uses: - 
% Used by:	?
%               Reggie Davidrajuh (c) August 2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global PN;

PList = PN.priority_list;
priority_based = any(PList);  % PList is not empty

if isempty(EIP) % if the the queue is empty then   
    EIP = NEIQ;    
    % events_in_progress=new_event_in_Q 
        
else %EIP not empty
   lengthEIP = length(EIP);
   i=1; quit_loop=0; 
   while and(le(i,lengthEIP), ~quit_loop)
       % the new event is placed accroding to the completion time
      if lt(NEIQ.completion_time, EIP(i).completion_time)
          quit_loop = 1;   
      elseif eq(NEIQ.completion_time, EIP(i).completion_time)
          quit_loop = 1;
          if (priority_based)
              t1 = NEIQ.event;              
              t2 = EIP(i).event;
              if lt(PList(t1), PList(t2)) % priority: t1 < t2
                  i=i+1;
              end
          end
      else   % NEIQ.completion_time > EIP(i).completion_time
          i=i+1;
      end %if lt(NEIQ.completion_time, EIP(i).completion_time), 
   end %while
   
   EIP=[EIP(1:i-1), NEIQ, EIP(i:end)]; % insert the event in progress 
end
