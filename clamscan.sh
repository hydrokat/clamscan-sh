d=$(date +%y-%m-%d-%T)

#Update virus definitions
echo "Updating virus definitions..."; echo ""
/usr/bin/freshclam
return_code=$?

# Display updating failed status message and exit, if update failed
if [ $return_code -ne 0 ]; then
    echo ""; echo "Failed to updating virus definitions... Virus scan aborted"; echo ""
    exit $return_code
fi

# Update virus definitions
echo "Updating virus definitions..."; echo ""
/usr/bin/freshclam
return_code=$?

# Display updating failed status message and exit, if update failed
if [ $return_code -ne 0 ]; then
    echo ""; echo "Failed to updating virus definitions... Virus scan aborted"; echo ""
    exit $return_code
fi

# Commence scan
echo "Update completed"; echo ""; echo "Commencing virus scan... (this may take some time)"; echo ""
/usr/bin/clamscan -r -l /var/log/clamscan_sched_$d.log --move=/tmp/malware /home

return_code=$?

# Display virus scan status message
if [ $return_code -ne 0 ] && [ $return_code -ne 1 ]; then
    echo "";echo "Failed to complete virus scan"; echo ""
else
    echo ""; echo -n "Virus scan completed successfully. Review the log file."
fi

exit $return_code
