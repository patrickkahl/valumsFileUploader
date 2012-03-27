<?php if(!$this->doFiles): ?>     
    <h3><?php echo $GLOBALS['TL_LANG']['UPL']['be_upload_file']['0']; ?></h3>
<?php endif; ?>
<div class="backend" id="file-uploader">       
    <noscript>          
        <p><?php echo sprintf($GLOBALS['TL_LANG']['ERR']['val_be_noscript'], $this->noJsBeLink); ?></p>
    </noscript>
</div>

<script type="text/javascript">
    /* <![CDATA[ */
	
    function createUploader(){        
        var uploader = new qq.FileUploader({            
            element: document.getElementById('file-uploader'),
            // path to server-side upload script
            action: '<?php echo $this->action; ?>',            
            // additional data to send, name-value pairs
            params: {
                action: '<?php echo $this->paramAction; ?>'
            },
            // ex. ['jpg', 'jpeg', 'png', 'gif'] or []
            allowedExtensions: [<?php echo $this->uploadTypes; ?>],        
            // set to true to output server response to console
            debug: <?php echo ($this->debug) ? "true" : "false"; ?>,
            sizeLimit: <?php echo ($this->maxFileSize) ? $this->maxFileSize : '""'; ?>,
            // Template wrapper for all items
            template: '<div class="qq-uploader">' + 
                '<div class="qq-upload-drop-area"><span><?php echo (strlen($this->dropTextLabel) != 0) ? $this->dropTextLabel : $GLOBALS['TL_LANG']['UPL']['be_upload_drop_area']; ?><\/span><\/div>' +
                '<div class="qq-upload-button"><?php echo (strlen($this->dropButtonLabel) != 0) ? $this->dropButtonLabel : $GLOBALS['TL_LANG']['UPL']['be_upload_button']; ?><\/div>' +
                '<ul class="qq-upload-list"><\/ul>' + 
                '<\/div>',            
            // Template for one item in file list
            fileTemplate: '<li>' +
                '<span class="qq-upload-file"><\/span>' +
                '<span class="qq-upload-spinner"><\/span>' +
                '<span class="qq-upload-size"><\/span>' +
                '<a class="qq-upload-cancel" href="#"><?php echo $GLOBALS['TL_LANG']['UPL']['upload_cancel']; ?><\/a>' +
                '<span class="qq-upload-text"><?php echo $GLOBALS['TL_LANG']['UPL']['upload_failed_text']; ?><\/span>' +
                '<\/li>',
            // Error messages
            messages: {
                typeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_type_error']; ?>,
                sizeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_size_error']; ?>,
                minSizeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_min_size_error']; ?>,
                emptyError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_empty_error']; ?>,
                onLeave: <?php echo $GLOBALS['TL_LANG']['ERR']['val_on_leave']; ?>          
            },

            onComplete: function(id, fileName, responseJSON){
                var qqUploadListChilds = $$('#file-uploader .qq-upload-list').getChildren();
                var elem = qqUploadListChilds[0][id].getChildren('.qq-upload-text')[0];                
                
                if(responseJSON.success && responseJSON.resized || responseJSON.success && responseJSON.exceeds)
                {
                    elem.set({
                        'html' : responseJSON.resized_message, 
                        'class' : 'qq-upload-success-text'
                    });                      
                }
                else if(responseJSON.success)
                {
                    elem.set({
                        'html' : '', 
                        'class' : 'qq-upload-success-text'
                    });                    
                }
            
                <?php if($this->detailsFailureMessage): ?>
                if(!responseJSON.success)
                {
                    elem.set({
                        'html' : responseJSON.reasonText, 
                        'class': 'qq-upload-failed-text'
                    }); 
                }
                <?php endif; ?>
            }
        });

    }
        
    window.addEvent('domready', function(){
        window.onload = createUploader;	
    });
	
    /* ]]> */
</script>

<?php if(!$this->doFiles && $this->description == NULL): ?>
    <p class="tl_help tl_tip"><?php echo $GLOBALS['TL_LANG']['UPL']['be_upload_file']['1']; ?></p>
<?php endif; ?>