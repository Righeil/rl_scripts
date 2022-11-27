class Event {
    entity = null;
    instance = null;
    function_name = null;

    constructor(event_name, instance, function_name) {
        entity = SpawnEntityFromTable("logic_eventlistener", 
        {
            targetname = event_name,
            EventName = event_name,
            IsEnabled = true,
            FetchEventData = true,
            OnEventFired = event_name + ",RunScriptCode,event_fired(),0,-1",
        });

        this.instance = instance;
        this.function_name = function_name;

        entity.ValidateScriptScope();
        entity.GetScriptScope().event_fired <- function() {
            instance[function_name](event_data);
        }
    }
}