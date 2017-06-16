using System.Diagnostics;
using System.ServiceProcess;

namespace ADCommit
{
    public class Service : ServiceBase
    {
        private ADCommit _adCommit;
        private EventLog _eventLog;

        public Service()
        {
            _eventLog = new EventLog();
            if (!EventLog.SourceExists("ADCommit"))
            {
                EventLog.CreateEventSource("ADCommit", "ADCommit");
            }
            _eventLog.Source = "ADCommit";
            _eventLog.Log = "ADCommit";
            _adCommit = new ADCommit(_eventLog);
        }

        protected override void OnStart(string[] args)
        {
            _eventLog.WriteEntry("Service started.", EventLogEntryType.Information);
            _adCommit.Start();
        }

        protected override void OnStop()
        {
            _adCommit.Stop();
            _eventLog.WriteEntry("Service stopped.", EventLogEntryType.Information);
        }
    }
}
