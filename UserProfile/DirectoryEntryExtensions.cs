using System.DirectoryServices;

namespace UserProfile
{
    public static class DirectoryEntryExtensions
    {
        public static string GetStringProperty(this DirectoryEntry entry, string property)
        {
            if (entry == null)
            {
                return string.Empty;
            }

            if (entry.Properties[property].Value != null)
            {
                return (string)entry.Properties[property].Value;
            }
            else
            {
                return string.Empty;
            }
        }
    }
}
