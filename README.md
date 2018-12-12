# Economic Decision Study
## OA Sample

### 0.1.qualtrics-request.ipynb
1. Uses `config.py` to set Qualtrics API tokens and list of survey IDs
2. Makes Qualtrics API request to download survey data => `/sourcedata`

### 0.2.clean_nback.ipynb
1. Reads all individual-subject N-back data files <= `/sourcedata`
2. Situates data in trialwise long-format
3. Creates trialwise dataset with added Hit, FA, CR, Miss markers => `/derivatives`
4. Creates subjectwise dataset with Corrected Recognition and Avg RT (for Hits only) => `/derivatives`

### 0.3.clean_procspeed.ipynb
1. Reads all individual-subject ProcSpeed data files <= `/sourcedata`
2. Creates trialwise dataset with calculated *real* RT => `/derivatives`
3. Creates subjectwise dataset with average *real* RT => `/derivatives`

### 1.1.concat_subjects.ipynb
1. Read all individual-subject Main Task data files <= `/sourcedata`
2. Create trialwise dataset => `/derivatives`