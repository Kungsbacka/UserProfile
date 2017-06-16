using System.ServiceProcess;

namespace ADCommit
{
    static class Program
    {
        static void Main()
        {
#if DEBUG
            System.Diagnostics.EventLog eventLog = new System.Diagnostics.EventLog();
            eventLog.Source = "ADCommit";
            eventLog.Log = "ADCommit";
            (new ADCommit(eventLog)).Start();
            return;
#endif
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] 
			{ 
				new Service() 
			};
            ServiceBase.Run(ServicesToRun);
        }
    }
}
