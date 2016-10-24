function json2obj(self,fname)
%% json2obj
% 
% wrapper function for jsonlab -> save/load json files
% 
% author: john devitis
% create date: 24-Oct-2016 15:22:29
    fprintf('Loading object... ')
    if nargin < 2
        warning('please supply a source file (full file path)');
    end
    
    % get object field names
    cn = class(self);
    names = fieldnames(self);
     
    % load json to matlab struct
    tmp = loadjson(fname);
    allnames = fieldnames(tmp); % un-nest object(s) from root object
    
    for ii = 1:length(allnames);
        if strcmp(cn,allnames{ii})
            fprintf(' ... found object in file... ');
            jname = allnames{ii};            
        else
            fprintf('Did not find object in file. Aborting.\n');
            return
        end
    end
    
    jnames = fieldnames(tmp.(jname));
    % loop to populate consistent struct names of root object
    fprintf(' ... loading object contents... ');
    for ii = 1:length(names)
        for jj = 1:length(jnames)
            if strcmp(names{ii},jnames{jj})
                self.(names{ii}) = tmp.(jname).(names{ii});
            end
        end
    end
    
    fprintf('Done.\n');

	
end
