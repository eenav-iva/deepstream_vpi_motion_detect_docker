import os
import pandas as pd
import sys 
import csv
home = os.path.expanduser("~")
#root_dir = os.path.join(home, "/opt/data/")
stats_csv_name =  "motion_per_frame.csv"


# make target list
def summarize_stats(root_dir):
   target_list = []
   with open('summary_stats.csv', 'w') as f:
       w = csv.writer(f,delimiter=',')
       for dirpath, dirs, files in os.walk(root_dir):
           for f in files:
               print(f"{f}")
               if f == stats_csv_name :
                   stats_path = os.path.join(dirpath, f)
                   df2=pd.read_csv(stats_path)
                   print(df2.keys())
                #frame_number,motion,num_faces,num_person 
                   num_faces=df2['num_faces'].sum()
                   num_person=df2['num_person'].sum()
                   avg_motion=df2['motion'].mean()
                   w.writerow( [stats_path,avg_motion,num_faces,num_person] )

   return 


def main(args):

# Check input arguments
    if len(args) < 2:
        sys.stderr.write("usage: %s path\n" % args[0])
        sys.exit(1)
    else:
        summarize_stats(args[-1])
    
if __name__ == '__main__':
    sys.exit(main(sys.argv))    
##if __name__ == '__main__':
#   write_csv()
