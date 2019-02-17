function run_tracker_seq_KCF(seq_name)
    addpath('./KCF');
    base_path = 'D:\Mukul Ranjan\mukul\Context-based-Occlusion-Detection-Tracking-master\otb100\';
    
    if nargin==0,
        seq_name = choose_video(base_path);
    end
    % Loading seq info specified by 'seqName'.
    %pos: upleft corner of the target, (row, col);
    %target_sz: initial size of the target, (rows, cols)
    %ground_truth: [x, y, width, height]. (col,row,cols,rows)
    global ground_truth;
    [img_files, center, target_sz, ground_truth]=load_seq_info(base_path,seq_name);
    disp(['Processing Sequence ' seq_name '...']);
    update_visualization = show_video(seq_name, img_files);
        
    %% Tracking
    time = 0;  %to calculate FPS
    global bboxes;
    bboxes = zeros( numel( img_files ), 4 );  %tracking results
    for frame = 1:numel( img_files ),
        im=imread(img_files{frame});
        tic();
        
        if frame==1,
            target.tracker=KCF(im,center,target_sz);
        else
            track_output=target.tracker.track(im);
            bboxes( frame,:) = track_output;           
            target.tracker.update();          
        end
        time = time + toc();
        
        stop = update_visualization(frame);
        if stop, break, end  %user pressed Esc, stop early
        drawnow
    end
    
    precisions = precision_plot(seq_name,bboxes, ground_truth);
    fps= frame/time;
    save(['./Results1/' seq_name '_Ours'],'bboxes');   
    %fprintf('Seq: %s, FPS:% 4.2f\n', seq_name, fps)
    fprintf('%12s - Precision(last_px):% 1.3f, FPS:% 4.2f\n', seq_name, (precisions(numel(precisions))), fps)
    fprintf('%12s - mean Precision:% 1.3f, FPS:% 4.2f\n', seq_name, mean(precisions), fps)
    
end