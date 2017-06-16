using System;
using System.Diagnostics;
using System.IO;
using System.Configuration;
using System.DirectoryServices;

namespace ADCommit
{
    class ADCommit
    {
        private EventLog _eventLog;
        private FileSystemWatcher _watcher;

        public ADCommit(EventLog eventLog)
        {
            _eventLog = eventLog;
        }

        public void Start()
        {
            _watcher = new FileSystemWatcher(ConfigurationManager.AppSettings["ThumbnailPhotoFolder"], "*.jpg");
            _watcher.Changed += new FileSystemEventHandler(File_Changed);
            _watcher.NotifyFilter = NotifyFilters.LastWrite;
            _watcher.EnableRaisingEvents = true;
        }

        public void Stop()
        {
            _watcher.EnableRaisingEvents = false;
        }

        void File_Changed(object sender, FileSystemEventArgs e)
        {
            if (!File.Exists(e.FullPath))
            {
                return;
            }
            string guidFromFile = Path.GetFileNameWithoutExtension(e.FullPath);
            Guid guid;
            if (!Guid.TryParseExact(guidFromFile, "D", out guid))
            {
                _eventLog.WriteEntry("Invalid file name: " + e.Name, EventLogEntryType.Error);
                return;
            }
            string userName;
            try
            {
                using (DirectoryEntry de = new DirectoryEntry("LDAP://<GUID=" + guid.ToString("D") + ">"))
                {
                    de.RefreshCache(new string[] { "thumbnailPhoto", "sAMAccountName" });
                    userName = de.Properties["sAMAccountName"].Value as string;
                    byte[] imageBytes = File.ReadAllBytes(e.FullPath);
                    if (imageBytes.Length > 51200)
                    {
                        _eventLog.WriteEntry("Image is larger than 50 KiB: " + e.FullPath, EventLogEntryType.Error);
                        return;
                    }
                    de.Properties["thumbnailPhoto"].Value = imageBytes;
                    de.CommitChanges();
                }
            }
            catch(Exception ex)
            {
                _eventLog.WriteEntry("Commit failed:\r\n" + ex.Message, EventLogEntryType.Error);
                return;
            }
            File.Delete(e.FullPath);
            _eventLog.WriteEntry("Successfully committed thumbnailPhoto for user " + userName, EventLogEntryType.Information);
        }
    }
}
