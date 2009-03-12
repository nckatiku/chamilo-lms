-- This script updates the databases structure before migrating the data from
-- version 1.8.5 to version 1.8.6
-- it is intended as a standalone script, however, because of the multiple
-- databases related difficulties, it should be parsed by a PHP script in
-- order to connect to and update the right databases.
-- There is one line per query, allowing the PHP function file() to read
-- all lines separately into an array. The xxMAINxx-type markers are there
-- to tell the PHP script which database we're talking about.
-- By always using the keyword "TABLE" in the queries, we should be able
-- to retrieve and modify the table name from the PHP script if needed, which
-- will allow us to deal with the unique-database-type installations
--
-- This first part is for the main database
-- xxMAINxx
ALTER TABLE settings_current ADD UNIQUE unique_setting (variable, subkey, category, access_url);
ALTER TABLE settings_options ADD UNIQUE unique_setting_option (variable,value);
INSERT INTO settings_current (variable, subkey,type,category,selected_value,title,comment,scope,subkeytext)VALUES ('registration', 'phone', 'textfield', 'User', 'false', 'RegistrationRequiredFormsTitle','RegistrationRequiredFormsComment', NULL, 'Phone');
ALTER TABLE php_session CHANGE session_value session_value MEDIUMTEXT NOT NULL;
INSERT INTO settings_current (variable, subkey,type,category,selected_value,title,comment,scope,subkeytext)VALUES ('add_users_by_coach',NULL,'radio','Security','false','AddUsersByCoachTitle','AddUsersByCoachComment',NULL,NULL);
INSERT INTO settings_options (variable, value, display_text) VALUES ('add_users_by_coach', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('add_users_by_coach', 'false', 'No');
ALTER TABLE session ADD nb_days_access_before_beginning TINYINT NULL DEFAULT '0' AFTER date_end , ADD nb_days_access_after_end TINYINT NULL DEFAULT '0' AFTER nb_days_access_before_beginning ;
ALTER TABLE course_rel_user ADD INDEX (user_id);
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('course_create_active_tools', 'wiki', 'checkbox', 'Tools', 'true', 'CourseCreateActiveToolsTitle', 'CourseCreateActiveToolsComment', NULL, 'Wiki', 1, 0);
INSERT INTO settings_current (variable, subkey,type,category,selected_value,title,comment,scope,subkeytext)VALUES ('extend_rights_for_coach',NULL,'radio','Security','false','ExtendRightsForCoachTitle','ExtendRightsForCoachComment',NULL,NULL);
INSERT INTO settings_options (variable, value, display_text) VALUES ('extend_rights_for_coach', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('extend_rights_for_coach', 'false', 'No');
INSERT INTO settings_current (variable, subkey,type,category,selected_value,title,comment,scope,subkeytext)VALUES ('extend_rights_for_coach_on_surveys',NULL,'radio','Security','false','ExtendRightsForCoachOnSurveyTitle','ExtendRightsForCoachOnSurveyComment',NULL,NULL);
INSERT INTO settings_options (variable, value, display_text) VALUES ('extend_rights_for_coach_on_surveys', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('extend_rights_for_coach_on_surveys', 'false', 'No');
INSERT INTO settings_current (variable, subkey,type,category,selected_value,title,comment,scope,subkeytext)VALUES ('show_session_coach',NULL,'radio','Platform','false','ShowSessionCoachTitle','ShowSessionCoachComment',NULL,NULL);
INSERT INTO settings_options (variable, value, display_text) VALUES ('show_session_coach', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('show_session_coach', 'false', 'No');
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('course_create_active_tools','gradebook','checkbox','Tools','true','CourseCreateActiveToolsTitle','CourseCreateActiveToolsComment',NULL,'Gradebook',1,0);
INSERT INTO course_module (name, link, image, `row`, `column`, position) VALUES ('wiki','wiki/index.php','wiki.gif',2,3,'basic');
INSERT INTO course_module (name, link, image, `row`, `column`, position) VALUES ('gradebook','gradebook/index.php','gradebook.gif',2,2,'basic');
ALTER TABLE gradebook_category ADD session_id int DEFAULT NULL;
CREATE TABLE gradebook_result_log (id int NOT NULL auto_increment,id_result int NOT NULL,user_id int NOT NULL,evaluation_id int NOT NULL,date_log datetime default '0000-00-00 00:00:00',score float unsigned default NULL,PRIMARY KEY(id));
CREATE TABLE gradebook_linkeval_log (id int NOT NULL auto_increment,id_linkeval_log int NOT NULL,name text,description text,date_log int,weight smallint default NULL,visible tinyint default NULL,type varchar(20) NOT NULL,user_id_log int NOT NULL,PRIMARY KEY  (id));
INSERT INTO course_module (name, link, image, `row`, `column`, position) VALUES ('glossary','glossary/index.php','glossary.gif',2,1,'basic');
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('course_create_active_tools','glossary','checkbox','Tools','true','CourseCreateActiveToolsTitle','CourseCreateActiveToolsComment',NULL,'Glossary',1,0);
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('course_create_active_tools','notebook','checkbox','Tools','true','CourseCreateActiveToolsTitle','CourseCreateActiveToolsComment',NULL,'Notebook',1,0);
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('allow_users_to_create_courses',NULL,'radio','Course','true','AllowUsersToCreateCoursesTitle','AllowUsersToCreateCoursesComment',NULL,NULL,1,0);
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_users_to_create_courses','true','Yes'),('allow_users_to_create_courses','false','No');
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('course_create_active_tools','survey','checkbox','Tools','true','CourseCreateActiveToolsTitle','CourseCreateActiveToolsComment',NULL,'Survey',1,0);
ALTER TABLE user_field_values CHANGE user_id user_id int unsigned not null;
UPDATE TABLE settings_options SET display_text = 'YesWillDeletePermanently' WHERE variable = 'permanently_remove_deleted_files' and value = 'true';
UPDATE TABLE settings_options SET display_text = 'NoWillDeletePermanently' WHERE variable = 'permanently_remove_deleted_files' and value = 'false';
INSERT INTO settings_options (variable, value, display_text) VALUES ('breadcrumbs_course_homepage','session_name_and_course_title','SessionNameAndCourseTitle');
INSERT INTO course_module (name, link, image, `row`, `column`, position) VALUES ('notebook','notebook/index.php','notebook.gif',2,1,'basic');
CREATE TABLE  sys_calendar (  id int unsigned NOT NULL auto_increment,  title varchar(200) NOT NULL,  content text,  start_date datetime NOT NULL default '0000-00-00 00:00:00',  end_date datetime NOT NULL default '0000-00-00 00:00:00',  PRIMARY KEY  (id));
CREATE TABLE IF NOT EXISTS system_template (id int UNSIGNED NOT NULL auto_increment,  title varchar(250) NOT NULL,  comment text NOT NULL,  image varchar(250) NOT NULL,  content text NOT NULL,  PRIMARY KEY  (id));
CREATE TABLE reservation_category (id int unsigned NOT NULL auto_increment,  parent_id  int NOT NULL default 0,   name  varchar(128) NOT NULL default '',  PRIMARY KEY  ( id ));
CREATE TABLE reservation_category_rights (category_id  int NOT NULL default 0,   class_id  int NOT NULL default 0,   m_items  tinyint NOT NULL default 0);
CREATE TABLE reservation_item  (id int unsigned NOT NULL auto_increment,   category_id  int unsigned NOT NULL default 0,   course_code  varchar(40) NOT NULL default '',   name  varchar(128) NOT NULL default '',   description  text NOT NULL,   blackout  tinyint NOT NULL default 0,   creator  int unsigned NOT NULL default 0,  PRIMARY KEY  ( id ));
CREATE TABLE reservation_item_rights (item_id  int unsigned NOT NULL default 0,   class_id  int unsigned NOT NULL default 0,   edit_right  tinyint unsigned NOT NULL default 0,   delete_right  tinyint unsigned NOT NULL default 0,   m_reservation  tinyint unsigned NOT NULL default 0,   view_right  tinyint NOT NULL default 0,  PRIMARY KEY  ( item_id , class_id ));
CREATE TABLE reservation_main  (id int unsigned NOT NULL auto_increment,   subid  int unsigned NOT NULL default 0,   item_id  int unsigned NOT NULL default 0,   auto_accept  tinyint unsigned NOT NULL default 0,   max_users  int unsigned NOT NULL default 1,   start_at  datetime NOT NULL default '0000-00-00 00:00:00',   end_at  datetime NOT NULL default '0000-00-00 00:00:00',   subscribe_from  datetime NOT NULL default '0000-00-00 00:00:00',   subscribe_until  datetime NOT NULL default '0000-00-00 00:00:00',   subscribers  int unsigned NOT NULL default 0,   notes  text NOT NULL,   timepicker  tinyint NOT NULL default 0,   timepicker_min  int NOT NULL default 0,   timepicker_max  int NOT NULL default 0,  PRIMARY KEY  ( id ));
CREATE TABLE reservation_subscription  (dummy  int unsigned NOT NULL auto_increment,   user_id  int unsigned NOT NULL default 0,   reservation_id  int unsigned NOT NULL default 0,   accepted  tinyint unsigned NOT NULL default 0,   start_at  datetime NOT NULL default '0000-00-00 00:00:00',   end_at  datetime NOT NULL default '0000-00-00 00:00:00',  PRIMARY KEY  ( dummy ));
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext) VALUES ('allow_reservation', NULL, 'radio', 'Tools', 'false', 'AllowReservationTitle', 'AllowReservationComment', NULL, NULL);
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_reservation', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_reservation', 'false', 'No');
CREATE TABLE access_url_rel_user (access_url_id int unsigned NOT NULL, user_id int unsigned NOT NULL, PRIMARY KEY (access_url_id, user_id));
ALTER TABLE access_url_rel_user ADD INDEX idx_access_url_rel_user_user (user_id);
ALTER TABLE access_url_rel_user ADD INDEX idx_access_url_rel_user_access_url(access_url_id);
ALTER TABLE access_url_rel_user ADD INDEX idx_access_url_rel_user_access_url_user (user_id,access_url_id);
CREATE TABLE access_url_rel_course (access_url_id int unsigned NOT NULL, course_code char(40) NOT NULL, PRIMARY KEY (access_url_id, course_code));
CREATE TABLE access_url_rel_session (access_url_id int unsigned NOT NULL, session_id int unsigned NOT NULL, PRIMARY KEY (access_url_id, session_id));

CREATE TABLE user_friend(id bigint unsigned not null auto_increment,user_id int unsigned not null,friend_user_id int unsigned not null,relation_type int not null default 0,PRIMARY KEY(id));
ALTER TABLE user_friend ADD INDEX idx_user_friend_user(user_id);
ALTER TABLE user_friend ADD INDEX idx_user_friend_friend_user(friend_user_id);
ALTER TABLE user_friend ADD INDEX idx_user_friend_user_friend_user(user_id,friend_user_id);
CREATE TABLE user_friend_relation_type(id int unsigned not null auto_increment,title char(20),PRIMARY KEY(id));
CREATE TABLE user_api_key (id int unsigned NOT NULL auto_increment, user_id int unsigned NOT NULL, api_key char(32) NOT NULL, api_service char(10) NOT NULL default 'dokeos', PRIMARY KEY (id));
ALTER TABLE user_api_key ADD INDEX idx_user_api_keys_user (user_id);
CREATE TABLE message (id bigint unsigned not null auto_increment, user_sender_id int unsigned not null, user_receiver_id int unsigned not null,	msg_status tinyint unsigned not null default 0, send_date datetime not null default '0000-00-00 00:00:00', title varchar(255) not null, content text not null, PRIMARY KEY(id));
ALTER TABLE message ADD INDEX idx_message_user_sender(user_sender_id);
ALTER TABLE message ADD INDEX idx_message_user_receiver(user_receiver_id);
ALTER TABLE message ADD INDEX idx_message_user_sender_user_receiver(user_sender_id,user_receiver_id);
ALTER TABLE message ADD INDEX idx_message_msg_status(msg_status);
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='Institution';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='InstitutionUrl';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='siteName';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='emailAdministrator';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='administratorSurname';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='administratorName';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_administrator_data';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='stylesheets';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='campus_homepage';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='my_courses';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='reporting';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='platform_administration';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='my_agenda';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='my_profile';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_tabs' AND subkey='my_gradebook';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='administratorTelephone';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_email_addresses';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='show_different_course_language';
UPDATE settings_current SET access_url_changeable = 1 WHERE variable='display_categories_on_homepage';
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext) VALUES ('advanced_filemanager',NULL,'radio','Platform','false','AdvancedFileManagerTitle','AdvancedFileManagerComment',NULL,NULL);
INSERT INTO settings_options (variable, value, display_text) VALUES ('advanced_filemanager','true','Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('advanced_filemanager','false','No');
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url_changeable) VALUES ('allow_message_tool', NULL, 'radio', 'Tools', 'false', 'AllowMessageToolTitle', 'AllowMessageToolComment', NULL, NULL,0);
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_message_tool', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_message_tool', 'false', 'No');
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url_changeable) VALUES ('allow_social_tool', NULL, 'radio', 'Tools', 'false', 'AllowSocialToolTitle', 'AllowSocialToolComment', NULL, NULL, 0);
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_social_tool', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_social_tool', 'false', 'No');
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url_changeable) VALUES ('allow_students_to_browse_courses', NULL, 'radio', 'Platform', 'true', 'AllowStudentsToBrowseCoursesTitle', 'AllowStudentsToBrowseCoursesComment', NULL, NULL, 1);
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_students_to_browse_courses', 'true', 'Yes');
INSERT INTO settings_options (variable, value, display_text) VALUES ('allow_students_to_browse_courses', 'false', 'No');
ALTER TABLE user_field ADD field_filter tinyint default 0;
INSERT INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url_changeable) VALUES ('profile','apikeys','checkbox','User','false','ProfileChangesTitle','ProfileChangesComment',NULL,'ApiKeys', 0);
INSERT INTO user_friend_relation_type(id,title)VALUES(1,'SocialUnknow');
INSERT INTO user_friend_relation_type(id,title)VALUES(2,'SocialParent');
INSERT INTO user_friend_relation_type(id,title)VALUES(3,'SocialFriend');
INSERT INTO user_friend_relation_type(id,title)VALUES(4,'SocialGoodFriend');
INSERT INTO user_friend_relation_type(id,title)VALUES(5,'SocialEnemy');
INSERT INTO user_friend_relation_type(id,title)VALUES(6,'SocialDeleted');
CREATE TABLE course_field (id int NOT NULL auto_increment, field_type int NOT NULL DEFAULT 1, field_variable varchar(64) NOT NULL, field_display_text varchar(64), field_default_value text, field_order int, field_visible tinyint default 0, field_changeable tinyint default 0, field_filter tinyint default 0, tms TIMESTAMP, PRIMARY KEY(id));
CREATE TABLE course_field_values (id int NOT NULL auto_increment, course_code varchar(40) NOT NULL, field_id int NOT NULL, field_value text, tms TIMESTAMP, PRIMARY KEY(id));
CREATE TABLE session_field (id int NOT NULL auto_increment, field_type int NOT NULL DEFAULT 1, field_variable varchar(64) NOT NULL, field_display_text varchar(64), field_default_value text, field_order int, field_visible tinyint default 0, field_changeable tinyint default 0, field_filter tinyint default 0, tms TIMESTAMP, PRIMARY KEY(id));
CREATE TABLE session_field_values(id int NOT NULL auto_increment, session_id int NOT NULL, field_id int NOT NULL, field_value text, tms TIMESTAMP, PRIMARY KEY(id));
ALTER TABLE templates ADD image VARCHAR( 250 ) NOT NULL ;
INSERT IGNORE INTO settings_current (variable, subkey, type, category, selected_value, title, comment, scope, subkeytext, access_url, access_url_changeable) VALUES ('dokeos_database_version',NULL,'textfield',NULL,'1.8.6.18983','DokeosDatabaseVersion','',NULL,NULL,1,0);
INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleCourseTitle', 'TemplateTitleCourseTitleDescription', 'coursetitle.gif', '
<head>
            	{CSS}
            	<style type="text/css">
            	.gris_title         	{
            		color: silver;
            	}            	
            	h1
            	{
            		text-align: right;
            	}
				</style>
  
            </head>
            <body>
			<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
			<tbody>
			<tr>			
			<td style="vertical-align: middle; width: 50%;" colspan="1" rowspan="1">
				<h1>TITULUS 1<br>
				<span class="gris_title">TITULUS 2</span><br>
				</h1>
			</td>			
			<td style="width: 50%;">
				<img style="width: 100px; height: 100px;" alt="dokeos logo" src="{COURSE_DIR}images/logo_dokeos.png"></td>
			</tr>
			</tbody>
			</table>
			<p><br>
			<br>
			</p>
			</body>
');



INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleCheckList', 'TemplateTitleCheckListDescription', 'checklist.gif', '
      <head>
	               {CSS}	              
	            </head>
	            <body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
				<tr>
				<td style="vertical-align: top; width: 66%;">						
				<h3>Lorem ipsum dolor sit amet</h3>
				<ul>
					<li>consectetur adipisicing elit</li>
					<li>sed do eiusmod tempor incididunt</li>
					<li>ut labore et dolore magna aliqua</li>
				</ul>
				
				<h3>Ut enim ad minim veniam</h3>							
				<ul>
					<li>quis nostrud exercitation ullamco</li>
					<li>laboris nisi ut aliquip ex ea commodo consequat</li>
					<li>Excepteur sint occaecat cupidatat non proident</li>
				</ul>
				
				<h3>Sed ut perspiciatis unde omnis</h3>				
				<ul>
					<li>iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam</li>
					<li>eaque ipsa quae ab illo inventore veritatis</li>
					<li>et quasi architecto beatae vitae dicta sunt explicabo.&nbsp;</li>
				</ul>
				
				</td>
				<td style="background: transparent url({IMG_DIR}postit.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; width: 33%; text-align: center; vertical-align: bottom;">
				<h3>Ut enim ad minima</h3>
				Veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur.<br>
				<h3>
				<img style="width: 180px; height: 144px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_smile.png "><br></h3>
				</td>
				</tr>
				</tbody>
				</table>
				<p><br>
				<br>
				</p>
				</body>
');


INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleTeacher', 'TemplateTitleTeacherDescription', 'yourinstructor.gif', '
<head>
                   {CSS}
                   <style type="text/css">	            
	            	.text
	            	{	            	
	            		font-weight: normal;
	            	}
					</style>
                </head>                    
                <body>
					<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
					<tbody>
					<tr>
					<td></td>
					<td style="height: 33%;"></td>
					<td></td>
					</tr>
					<tr>
					<td style="width: 25%;"></td>
					<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: right; font-weight: bold;" colspan="1" rowspan="1">
					<span class="text">
					<br>
					Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Duis pellentesque.</span>
					</td>
					<td style="width: 25%; font-weight: bold;">
					<img style="width: 180px; height: 241px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_case.png "></td>
					</tr>
					</tbody>
					</table>
					<p><br>
					<br>
					</p>
				</body>	
');


INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleLeftList', 'TemplateTitleListLeftListDescription', 'leftlist.gif', '
<head>
	           {CSS}
	       </head>		    
		    <body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
				<tr>
				<td style="width: 66%;"></td>
				<td style="vertical-align: bottom; width: 33%;" colspan="1" rowspan="4">&nbsp;<img style="width: 180px; height: 248px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_reads.png "><br>
				</td>
				</tr>
				<tr align="right">
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 66%;">Lorem
				ipsum dolor sit amet.
				</td>
				</tr>
				<tr align="right">
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 66%;">
				Vivamus
				a quam.&nbsp;<br>
				</td>
				</tr>
				<tr align="right">
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 66%;">
				Proin
				a est stibulum ante ipsum.</td>
				</tr>
				</tbody>
				</table>
			<p><br>
			<br>
			</p>
			</body> 
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleLeftRightList', 'TemplateTitleLeftRightListDescription', 'leftrightlist.gif', '

<head>
	           {CSS}
		    </head>
			<body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; height: 400px; width: 720px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
				<tr>
				<td></td>
				<td style="vertical-align: top;" colspan="1" rowspan="4">&nbsp;<img style="width: 180px; height: 294px;" alt="Trainer" src="{COURSE_DIR}images/trainer/trainer_join_hands.png "><br>
				</td>
				<td></td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: right;">Lorem
				ipsum dolor sit amet.
				</td>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: left;">
				Convallis
				ut.&nbsp;Cras dui magna.</td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: right;">
				Vivamus
				a quam.&nbsp;<br>
				</td>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: left;">
				Etiam
				lacinia stibulum ante.<br>
				</td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: right;">
				Proin
				a est stibulum ante ipsum.</td>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: left;">
				Consectetuer
				adipiscing elit. <br>
				</td>
				</tr>
				</tbody>
				</table>
			<p><br>
			<br>
			</p>
			</body> 

');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleRightList', 'TemplateTitleRightListDescription', 'rightlist.gif', '
	<head>
	           {CSS}
		    </head>
		    <body style="direction: ltr;">
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
				<tr>
				<td style="vertical-align: bottom; width: 50%;" colspan="1" rowspan="4"><img style="width: 300px; height: 199px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_points_right.png"><br>
				</td>
				<td style="width: 50%;"></td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; text-align: left; width: 50%;">
				Convallis
				ut.&nbsp;Cras dui magna.</td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; text-align: left; width: 50%;">
				Etiam
				lacinia.<br>
				</td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; text-align: left; width: 50%;">
				Consectetuer
				adipiscing elit. <br>
				</td>
				</tr>
				</tbody>
				</table>
			<p><br>
			<br>
			</p>
			</body>  
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleComparison', 'TemplateTitleComparisonDescription', 'compare.gif', '
<head>
            {CSS}        
            </head>
            
            <body>
            	<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">				
				<tr>
					<td style="height: 10%; width: 33%;"></td> 
					<td style="vertical-align: top; width: 33%;" colspan="1" rowspan="2">&nbsp;<img style="width: 180px; height: 271px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_standing.png "><br>
					</td>
					<td style="height: 10%; width: 33%;"></td>
				</tr>
			<tr>
			<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 33%; text-align: right;">
			Lorem ipsum dolor sit amet.
			</td>
			<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; text-align: left; width: 33%;">
			Convallis
			ut.&nbsp;Cras dui magna.</td>
			</tr>			
			</body>
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleDiagram', 'TemplateTitleDiagramDescription', 'diagram.gif', '
	<head>
	                   {CSS}
				    </head>
				    
					<body>
					<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
					<tbody>
					<tr>
					<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; text-align: left; height: 33%; width: 33%;">
					<br>
					Etiam
					lacinia stibulum ante.
					Convallis
					ut.&nbsp;Cras dui magna.</td>
					<td colspan="1" rowspan="3">
						<img style="width: 350px; height: 267px;" alt="Alaska chart" src="{COURSE_DIR}images/diagrams/alaska_chart.png "></td>
					</tr>
					<tr>
					<td colspan="1" rowspan="1">
					<img style="width: 300px; height: 199px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_points_right.png "></td>
					</tr>
					<tr>
					</tr>
					</tbody>
					</table>
					<p><br>
					<br>
					</p>
					</body>				    
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleDesc', 'TemplateTitleCheckListDescription', 'description.gif', '
<head>
	                   {CSS}
				    </head>
					<body>
						<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
						<tbody>
						<tr>
						<td style="width: 50%; vertical-align: top;">
							<img style="width: 48px; height: 49px; float: left;" alt="01" src="{COURSE_DIR}images/small/01.png " hspace="5"><br>Lorem ipsum dolor sit amet<br><br><br>
							<img style="width: 48px; height: 49px; float: left;" alt="02" src="{COURSE_DIR}images/small/02.png " hspace="5">
							<br>Ut enim ad minim veniam<br><br><br>
							<img style="width: 48px; height: 49px; float: left;" alt="03" src="{COURSE_DIR}images/small/03.png " hspace="5">Duis aute irure dolor in reprehenderit<br><br><br>
							<img style="width: 48px; height: 49px; float: left;" alt="04" src="{COURSE_DIR}images/small/04.png " hspace="5">Neque porro quisquam est</td>
							
						<td style="vertical-align: top; width: 50%; text-align: right;" colspan="1" rowspan="1">
							<img style="width: 300px; height: 291px;" alt="Gearbox" src="{COURSE_DIR}images/diagrams/gearbox.jpg "><br></td>
						</tr><tr></tr>
						</tbody>
						</table>
						<p><br>
						<br>
						</p>
					</body>	
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleObjectives', 'TemplateTitleObjectivesDescription', 'courseobjectives.gif', '
<head>
	               {CSS}                    
			    </head>	
			    
			    <body>
					<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
					<tbody>
					<tr>
					<td style="vertical-align: bottom; width: 33%;" colspan="1" rowspan="2">
					<img style="width: 180px; height: 271px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_chair.png "><br>
					</td>
					<td style="height: 10%; width: 66%;"></td>
					</tr>
					<tr>
					<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; text-align: left; width: 66%;">
					<h3>Lorem ipsum dolor sit amet</h3>
					<ul>
					<li>consectetur adipisicing elit</li>
					<li>sed do eiusmod tempor incididunt</li>
					<li>ut labore et dolore magna aliqua</li>
					</ul>
					<h3>Ut enim ad minim veniam</h3>
					<ul>
					<li>quis nostrud exercitation ullamco</li>
					<li>laboris nisi ut aliquip ex ea commodo consequat</li>
					<li>Excepteur sint occaecat cupidatat non proident</li>
					</ul>
					</td>
					</tr>
					</tbody>
					</table>
				<p><br>
				<br>
				</p>
				</body>		
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleCycle', 'TemplateTitleCycleDescription', 'cyclechart.gif', '
<head>
	               {CSS}
	               <style>
	               .title
	               {
	               	color: white; font-weight: bold;
	               }
	               </style>                    
			    </head>
			    	
			    	    
			    <body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="8" cellspacing="6">
				<tbody>
				<tr>
					<td style="text-align: center; vertical-align: bottom; height: 10%;" colspan="3" rowspan="1">
						<img style="width: 250px; height: 76px;" alt="arrow" src="{COURSE_DIR}images/diagrams/top_arrow.png ">
					</td>				
				</tr>			
				<tr>
					<td style="height: 5%; width: 45%; vertical-align: top; background-color: rgb(153, 153, 153); text-align: center;">
						<span class="title">Lorem ipsum</span>
					</td>
						
					<td style="height: 5%; width: 10%;"></td>					
					<td style="height: 5%; vertical-align: top; background-color: rgb(153, 153, 153); text-align: center;">
						<span class="title">Sed ut perspiciatis</span>
					</td>
				</tr>
					<tr>
						<td style="background-color: rgb(204, 204, 255); width: 45%; vertical-align: top;">
							<ul>
								<li>dolor sit amet</li>
								<li>consectetur adipisicing elit</li>
								<li>sed do eiusmod tempor&nbsp;</li>
								<li>adipisci velit, sed quia non numquam</li>
								<li>eius modi tempora incidunt ut labore et dolore magnam</li>
							</ul>
				</td>			
				<td style="width: 10%;"></td>
				<td style="background-color: rgb(204, 204, 255); width: 45%; vertical-align: top;">
					<ul>
					<li>ut enim ad minim veniam</li>
					<li>quis nostrud exercitation</li><li>ullamco laboris nisi ut</li>
					<li> Quis autem vel eum iure reprehenderit qui in ea</li>
					<li>voluptate velit esse quam nihil molestiae consequatur,</li>
					</ul>
					</td>
					</tr>
					<tr align="center">
					<td style="height: 10%; vertical-align: top;" colspan="3" rowspan="1">
					<img style="width: 250px; height: 76px;" alt="arrow" src="{COURSE_DIR}images/diagrams/bottom_arrow.png ">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
				</td>
				</tr>			
				</tbody>
				</table>
				<p><br>
				<br>
				</p>
				</body>	
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleLearnerWonder', 'TemplateTitleLearnerWonderDescription', 'learnerwonder.gif', '
<head>
               {CSS}                    
		    </head>
		    
		    <body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
				<tr>
				<td style="width: 33%;" colspan="1" rowspan="4">
					<img style="width: 120px; height: 348px;" alt="learner wonders" src="{COURSE_DIR}images/silhouette.png "><br>
				</td>
				<td style="width: 66%;"></td>
				</tr>
				<tr align="center">
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 66%;">
				Convallis
				ut.&nbsp;Cras dui magna.</td>
				</tr>
				<tr align="center">
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 66%;">
				Etiam
				lacinia stibulum ante.<br>
				</td>
				</tr>
				<tr align="center">
				<td style="background: transparent url({IMG_DIR}faded_grey.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 66%;">
				Consectetuer
				adipiscing elit. <br>
				</td>
				</tr>
				</tbody>
				</table>
			<p><br>
			<br>
			</p>
			</body>
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleTimeline', 'TemplateTitleTimelineDescription', 'phasetimeline.gif', '
<head>
               {CSS} 
				<style>
				.title
				{				
					font-weight: bold; text-align: center; 	
				}			
				</style>                
		    </head>	
		    
		    <body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="8" cellspacing="5">
				<tbody>
				<tr class="title">				
					<td style="vertical-align: top; height: 3%; background-color: rgb(224, 224, 224);">Lorem ipsum</td>
					<td style="height: 3%;"></td>
					<td style="vertical-align: top; height: 3%; background-color: rgb(237, 237, 237);">Perspiciatis</td>
					<td style="height: 3%;"></td>
					<td style="vertical-align: top; height: 3%; background-color: rgb(245, 245, 245);">Nemo enim</td>
				</tr>
				
				<tr>
					<td style="vertical-align: top; width: 30%; background-color: rgb(224, 224, 224);">
						<ul>
						<li>dolor sit amet</li>
						<li>consectetur</li>
						<li>adipisicing elit</li>
					</ul>
					<br>
					</td>
					<td>
						<img style="width: 32px; height: 32px;" alt="arrow" src="{COURSE_DIR}images/small/arrow.png ">
					</td>
					
					<td style="vertical-align: top; width: 30%; background-color: rgb(237, 237, 237);">
						<ul>
							<li>ut labore</li>
							<li>et dolore</li>
							<li>magni dolores</li>
						</ul>
					</td>
					<td>
						<img style="width: 32px; height: 32px;" alt="arrow" src="{COURSE_DIR}images/small/arrow.png ">
					</td>
					
					<td style="vertical-align: top; background-color: rgb(245, 245, 245); width: 30%;">
						<ul>
							<li>neque porro</li>
							<li>quisquam est</li>
							<li>qui dolorem&nbsp;&nbsp;</li>
						</ul>
						<br><br>
					</td>
				</tr>
				</tbody>
				</table>
			<p><br>
			<br>
			</p>
			</body>
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleStopAndThink', 'TemplateTitleStopAndThinkDescription', 'stopthink.gif', '
<head>
               {CSS}                    
		    </head>
		    <body>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
				<tr>
				<td style="vertical-align: bottom; width: 33%;" colspan="1" rowspan="2">
					<img style="width: 180px; height: 169px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_staring.png ">
				<br>
				</td>
				<td style="height: 10%; width: 66%;"></td>
				</tr>
				<tr>
				<td style="background: transparent url({IMG_DIR}postit.png ) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; width: 66%; vertical-align: middle; text-align: center;">
					<h3>Attentio sectetur adipisicing elit</h3>
					<ul>
						<li>sed do eiusmod tempor incididunt</li>
						<li>ut labore et dolore magna aliqua</li>
						<li>quis nostrud exercitation ullamco</li>
					</ul><br></td>
				</tr>
				</tbody>
				</table>
			<p><br>
			<br>
			</p>
			</body>
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleTable', 'TemplateTitleCheckListDescription', 'table.gif', '
<head>
                   {CSS}
                   <style type="text/css">
				.title
				{
					font-weight: bold; text-align: center;
				}
				
				.items
				{
					text-align: right;
				}	
  				

					</style>
  
			    </head>
			    <body>
			    <br />
			   <h2>A table</h2>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px;" border="1" cellpadding="5" cellspacing="0">
				<tbody>
				<tr class="title">
					<td>City</td>
					<td>2005</td>
					<td>2006</td>
					<td>2007</td>
					<td>2008</td>
				</tr>
				<tr class="items">
					<td>Lima</td>
					<td>10,40</td>
					<td>8,95</td>
					<td>9,19</td>
					<td>9,76</td>
				</tr>
				<tr class="items">
				<td>New York</td>
					<td>18,39</td>
					<td>17,52</td>
					<td>16,57</td>
					<td>16,60</td>
				</tr>
				<tr class="items">
				<td>Barcelona</td>
					<td>0,10</td>
					<td>0,10</td>
					<td>0,05</td>
					<td>0,05</td>
				</tr>
				<tr class="items">
				<td>Paris</td>
					<td>3,38</td>
					<td >3,63</td>
					<td>3,63</td>
					<td>3,54</td>
				</tr>
				</tbody>
				</table>
				<br>
				</body>
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleAudio', 'TemplateTitleAudioDescription', 'audiocomment.gif', '
<head>
               {CSS}                    
		    </head>
                   <body>
					<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
					<tbody>
					<tr>
					<td>					
					<div align="center">
					<span style="text-align: center;">
						<embed  type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" width="300" height="20" bgcolor="#FFFFFF" src="{REL_PATH}main/inc/lib/mediaplayer/player.swf" allowfullscreen="false" allowscriptaccess="always" flashvars="file={COURSE_DIR}audio/ListeningComprehension.mp3&amp;autostart=true"></embed>
                    </span></div>     
					
					<br>
					</td>
					<td colspan="1" rowspan="3"><br>
						<img style="width: 300px; height: 341px; float: right;" alt="image" src="{COURSE_DIR}images/diagrams/head_olfactory_nerve.png "><br></td>
					</tr>
					<tr>
					<td colspan="1" rowspan="1">
						<img style="width: 180px; height: 271px;" alt="trainer" src="{COURSE_DIR}images/trainer/trainer_glasses.png"><br></td>
					</tr>
					<tr>
					</tr>
					</tbody>
					</table>
					<p><br>
					<br>
					</p>
					</body>	
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleVideo', 'TemplateTitleVideoDescription', 'video.gif', '
<head>
            	{CSS}
			</head>
			
			<body>
			<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 720px; height: 400px;" border="0" cellpadding="15" cellspacing="6">
			<tbody>
			<tr>
			<td style="width: 50%; vertical-align: top;">
			                
        <div style="border-style: none; overflow: hidden; height: 200px; width: 300px; background-color: rgb(220, 220, 220); background-image: url({REL_PATH}main/inc/lib/fckeditor/editor/plugins/flvPlayer/flvPlayer.gif); background-repeat: no-repeat; background-position: center center;"><script src="{REL_PATH}main/inc/lib/fckeditor/editor/plugins/flvPlayer/swfobject.js" type="text/javascript"></script>
        <div id="player810625"><a href="http://www.macromedia.com/go/getflashplayer">Get the Flash Player</a> to see this player.
        <div id="player810625-config" style="overflow: hidden; display: none; visibility: hidden; width: 0px; height: 0px;">url={REL_PATH}main/default_course_document/video/flv/example.flv width=400 height=200 loop=false play=false downloadable=false fullscreen=true displayNavigation=true displayDigits=true align=left dispPlaylist=none playlistThumbs=false</div>

        </div>
        <script type="text/javascript">
	var s1 = new SWFObject("{REL_PATH}main/inc/lib/fckeditor/editor/plugins/flvPlayer/mediaplayer.swf","single","400","200","7");
	s1.addVariable("width","400");
	s1.addVariable("height","200");
	s1.addVariable("autostart","false");
	s1.addVariable("file","{REL_PATH}main/default_course_document/video/flv/example.flv");
s1.addVariable("repeat","false");
	s1.addVariable("image","");
	s1.addVariable("showdownload","false");
	s1.addVariable("link","{REL_PATH}main/default_course_document/video/flv/example.flv");
	s1.addParam("allowfullscreen","true");
	s1.addVariable("showdigits","true");
	s1.addVariable("shownavigation","true");
	s1.addVariable("logo","");
	s1.write("player810625");
</script></div>
			   	
			</td>
			<td style="background: transparent url({IMG_DIR}faded_grey.png) repeat scroll center top; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; vertical-align: top; width: 50%;">
			<h3><br>
			</h3>
			<h3>Lorem ipsum dolor sit amet</h3>
				<ul>
				<li>consectetur adipisicing elit</li>
				<li>sed do eiusmod tempor incididunt</li>
				<li>ut labore et dolore magna aliqua</li>
				</ul>
			<h3>Ut enim ad minim veniam</h3>
				<ul>
				<li>quis nostrud exercitation ullamco</li>
				<li>laboris nisi ut aliquip ex ea commodo consequat</li>
				<li>Excepteur sint occaecat cupidatat non proident</li>
				</ul>
			</td>
			</tr>
			</tbody>
			</table>
			<p><br>
			<br>
			</p>
			 <style type="text/css">body{}</style><!-- to fix a strange bug appearing with firefox when editing this template -->
			</body>
');

INSERT INTO system_template (title, comment, image, content) VALUES
('TemplateTitleFlash', 'TemplateTitleFlashDescription', 'flash.gif', '
<head>
               {CSS}                    
		    </head>				    
		    <body>
		    <center>
				<table style="background: transparent url({IMG_DIR}faded_blue_horizontal.png ) repeat scroll 0% 50%; -moz-background-clip: initial; -moz-background-origin: initial; -moz-background-inline-policy: initial; text-align: left; width: 100%; height: 400px;" border="0" cellpadding="15" cellspacing="6">
				<tbody>
					<tr>
					<td align="center">
					<embed width="700" height="300" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" src="{COURSE_DIR}flash/SpinEchoSequence.swf" play="true" loop="true" menu="true"></embed></span><br /> 				          													
					</td>
					</tr>
				</tbody>
				</table>
				<p><br>
				<br>
				</p>
			</center>
			</body>
');




-- xxSTATSxx
ALTER TABLE track_e_exercices ADD status varchar(20) NOT NULL default '';
ALTER TABLE track_e_exercices ADD data_tracking text NOT NULL default '';
ALTER TABLE track_e_exercices ADD steps_counter SMALLINT UNSIGNED NOT NULL default 0;
ALTER TABLE track_e_exercices ADD start_date datetime NOT NULL default '0000-00-00 00:00:00';
ALTER TABLE track_e_exercices ADD session_id SMALLINT UNSIGNED NOT NULL default 0;
ALTER TABLE track_e_exercices ADD INDEX ( session_id ) ;
CREATE TABLE track_e_attempt_recording (exe_id int unsigned NOT NULL, question_id int unsigned NOT NULL,  marks int NOT NULL,  insert_date datetime NOT NULL default '0000-00-00 00:00:00',  author int unsigned NOT NULL,  teacher_comment text NOT NULL);
ALTER TABLE track_e_attempt_recording ADD INDEX (exe_id);
ALTER TABLE track_e_hotspot CHANGE hotspot_coordinate hotspot_coordinate text NOT NULL;
ALTER TABLE track_e_exercices ADD orig_lp_id int  NOT NULL default 0;
ALTER TABLE track_e_exercices ADD orig_lp_item_id int  NOT NULL default 0;
ALTER TABLE track_e_exercices ADD exe_duration int UNSIGNED NOT NULL default 0;
ALTER TABLE track_e_exercices CHANGE exe_result exe_result FLOAT( 6, 2 ) NOT NULL DEFAULT 0;
ALTER TABLE track_e_exercices CHANGE exe_weighting exe_weighting FLOAT( 6, 2 ) NOT NULL DEFAULT 0;
ALTER TABLE track_e_attempt CHANGE marks marks FLOAT( 6, 2 ) NOT NULL DEFAULT 0;
-- xxUSERxx

-- xxCOURSExx
ALTER TABLE course_setting ADD INDEX unique_setting (variable,subkey,category);
ALTER TABLE lp ADD theme varchar(255) not null default '';
ALTER TABLE survey ADD mail_subject VARCHAR( 255 ) NOT NULL AFTER reminder_mail ;
ALTER TABLE quiz_rel_question ADD question_order mediumint unsigned NOT NULL default 1;
ALTER TABLE quiz ADD max_attempt int NOT NULL default 0;
ALTER TABLE survey ADD one_question_per_page bool NOT NULL default 0;
ALTER TABLE survey ADD shuffle bool NOT NULL default 0;
ALTER TABLE survey ADD survey_version varchar(255) NOT NULL default '';
ALTER TABLE survey ADD parent_id int NOT NULL default 0;
ALTER TABLE survey ADD survey_type int NOT NULL default 0;
ALTER TABLE survey_question ADD survey_group_pri int unsigned NOT NULL default 0;
ALTER TABLE survey_question ADD survey_group_sec1 int unsigned NOT NULL default 0;
ALTER TABLE survey_question ADD survey_group_sec2 int unsigned NOT NULL default 0;
CREATE TABLE survey_group (  id int unsigned NOT NULL auto_increment, name varchar(20) NOT NULL, description varchar(255) NOT NULL,  survey_id int unsigned NOT NULL, PRIMARY KEY  (id) );
ALTER TABLE survey_question_option ADD value int NOT NULL default 0;
UPDATE tool SET category = 'interaction' WHERE name = 'forum';
ALTER TABLE survey ADD show_form_profile int NOT NULL default 0;
ALTER TABLE survey ADD form_fields TEXT NOT NULL;
ALTER TABLE quiz_answer CHANGE hotspot_type hotspot_type ENUM( 'square', 'circle', 'poly', 'delineation' ) NULL DEFAULT NULL;
ALTER TABLE quiz ADD start_time datetime NOT NULL default '0000-00-00 00:00:00';
ALTER TABLE quiz ADD end_time datetime NOT NULL default '0000-00-00 00:00:00';
ALTER TABLE quiz ADD max_attempt int NOT NULL default 0;
ALTER TABLE forum_forum ADD forum_image varchar(255) NOT NULL default '';
ALTER TABLE lp ADD preview_image varchar(255) NOT NULL default '';
ALTER TABLE lp ADD author varchar(255) NOT NULL default '';
ALTER TABLE lp_item ADD terms TEXT NULL;
ALTER TABLE lp_item ADD search_did INT NULL;
CREATE TABLE wiki (id int NOT NULL auto_increment, page_id int NOT NULL default 0, reflink varchar(250) NOT NULL default 'index', title text NOT NULL, content mediumtext NOT NULL, user_id int NOT NULL default 0, group_id int default NULL, dtime datetime NOT NULL default '0000-00-00 00:00:00', addlock int NOT NULL default 1, editlock int NOT NULL default 0, visibility int NOT NULL default 1, addlock_disc int NOT NULL default 1, visibility_disc int NOT NULL default 1, ratinglock_disc int NOT NULL default 1, assignment int NOT NULL default 0, comment text NOT NULL, progress text NOT NULL, score int default 0, version int default NULL, is_editing int NOT NULL default 0, hits int default 0, linksto text NOT NULL, tag text NOT NULL, user_ip varchar(39) NOT NULL, PRIMARY KEY  (id) );
INSERT INTO tool(name,link,image,visibility,admin,address,added_tool,target,category) VALUES ('wiki','wiki/index.php','wiki.gif',0,'0','squaregrey.gif',0,'_self','interaction');
ALTER TABLE group_category ADD COLUMN wiki_state tinyint unsigned NOT NULL default 1;
ALTER TABLE group_info ADD COLUMN wiki_state tinyint unsigned NOT NULL default 1;
ALTER TABLE announcement ADD session_id SMALLINT UNSIGNED NOT NULL default 0;
ALTER TABLE announcement ADD INDEX ( session_id ) ;
ALTER TABLE forum_category ADD session_id SMALLINT UNSIGNED NOT NULL default 0;
ALTER TABLE forum_category ADD INDEX ( session_id ) ;
ALTER TABLE student_publication ADD session_id SMALLINT UNSIGNED NOT NULL default 0 ;
ALTER TABLE student_publication ADD INDEX ( session_id ) ;
ALTER TABLE calendar_event ADD session_id int unsigned NOT NULL default 0 ;
ALTER TABLE calendar_event ADD INDEX ( session_id ) ;
ALTER TABLE group_info ADD session_id SMALLINT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE group_info ADD INDEX ( session_id ) ;
ALTER TABLE survey ADD session_id SMALLINT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE survey ADD INDEX ( session_id ) ;
CREATE TABLE wiki_discuss (id int NOT NULL auto_increment, publication_id int NOT NULL default 0, userc_id int NOT NULL default 0, comment text NOT NULL, p_score varchar(255) default NULL, dtime datetime NOT NULL default '0000-00-00 00:00:00', PRIMARY KEY  (id) );
CREATE TABLE wiki_mailcue (id int NOT NULL, user_id int NOT NULL, type text NOT NULL, group_id int DEFAULT NULL, KEY  (id) );
ALTER TABLE lp_item ADD audio VARCHAR(250);
CREATE TABLE wiki_conf (id int NOT NULL auto_increment, page_id int NOT NULL default 0, feedback1 text NOT NULL, feedback2 text NOT NULL, feedback3 text NOT NULL, max_size int default NULL, max_text int default NULL, max_version int default NULL, startdate_assig datetime NOT NULL default '0000-00-00 00:00:00', enddate_assig datetime NOT NULL default '0000-00-00 00:00:00', delayedsubmit int NOT NULL default 0, PRIMARY KEY  (id) );
CREATE TABLE student_publication_assignment (id int NOT NULL auto_increment, expires_on datetime NOT NULL default '0000-00-00 00:00:00',  ends_on datetime NOT NULL default '0000-00-00 00:00:00',  add_to_calendar tinyint NOT NULL,  enable_qualification tinyint NOT NULL,  publication_id int NOT NULL,  PRIMARY KEY  (id));
ALTER TABLE student_publication ADD has_properties INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE student_publication ADD qualification float(6,2) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE student_publication ADD date_of_qualification datetime NOT NULL default '0000-00-00 00:00:00';
ALTER TABLE student_publication ADD parent_id INT UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE student_publication ADD qualificator_id INT UNSIGNED NOT NULL DEFAULT 0;
CREATE TABLE forum_thread_qualify (id int unsigned PRIMARY KEY AUTO_INCREMENT, user_id int unsigned NOT NULL,thread_id int NOT NULL,qualify float(6,2) NOT NULL default 0,qualify_user_id int default NULL,qualify_time datetime NOT NULL default '0000-00-00 00:00:00', session_id int default NULL);
ALTER TABLE forum_thread_qualify ADD INDEX (user_id, thread_id);
ALTER TABLE forum_thread ADD session_id int unsigned default NULL;
ALTER TABLE forum_thread ADD thread_title_qualify varchar(255) default '';
ALTER TABLE forum_thread ADD thread_qualify_max float(6,2) UNSIGNED NOT NULL DEFAULT 0;
CREATE TABLE forum_thread_qualify_log (id int unsigned PRIMARY KEY AUTO_INCREMENT, user_id int unsigned NOT NULL,thread_id int NOT NULL,qualify float(6,2) NOT NULL default 0,qualify_user_id int default NULL,qualify_time datetime NOT NULL default '0000-00-00 00:00:00', session_id int default NULL);
ALTER TABLE forum_thread_qualify_log ADD INDEX (user_id, thread_id);
INSERT INTO tool(name,link,image,visibility,admin,address,added_tool,target,category) VALUES ('gradebook','gradebook/index.php','gradebook.gif',1,'0','squaregrey.gif',0,'_self','authoring');
ALTER TABLE forum_thread ADD thread_close_date datetime default '0000-00-00 00:00:00';
ALTER TABLE student_publication ADD view_properties tinyint NULL;
UPDATE forum_notification SET forum_id=NULL WHERE forum_id='';
ALTER TABLE forum_notification CHANGE forum_id forum_id INT;
UPDATE forum_notification SET thread_id=NULL WHERE thread_id='';
ALTER TABLE forum_notification CHANGE thread_id thread_id INT;
UPDATE forum_notification SET post_id=NULL WHERE post_id='';
ALTER TABLE forum_notification CHANGE post_id post_id INT NULL;
ALTER TABLE forum_thread ADD thread_weight float(6,2) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE forum_notification CHANGE post_id post_id INT;
ALTER TABLE quiz_answer CHANGE hotspot_coordinates hotspot_coordinates text;
ALTER TABLE group_info ADD forum_state TINYINT unsigned NOT NULL default 0 AFTER announcements_state;
CREATE TABLE calendar_event_attachment ( id int NOT NULL auto_increment, path varchar(255) NOT NULL, comment text, size int NOT NULL default 0, agenda_id int NOT NULL, filename varchar(255) NOT NULL, PRIMARY KEY (id) );
CREATE TABLE notebook (notebook_id int unsigned NOT NULL auto_increment,user_id int unsigned NOT NULL,course varchar(40) not null,session_id int NOT NULL default 0,title varchar(255) NOT NULL,description text NOT NULL,creation_date datetime NOT NULL default '0000-00-00 00:00:00',update_date datetime NOT NULL default '0000-00-00 00:00:00', status int, PRIMARY KEY (notebook_id));
INSERT INTO course_setting(variable,value,category) VALUES ('allow_open_chat_window',0,'chat');
INSERT INTO course_setting(variable,value,category) VALUES ('email_alert_to_teacher_on_new_user_in_course',0,'registration');
INSERT INTO tool(name,link,image,visibility,admin,address,added_tool,target,category) VALUES ('glossary','glossary/index.php','glossary.gif',0,'0','squaregrey.gif',0,'_self','authoring');
INSERT INTO tool(name,link,image,visibility,admin,address,added_tool,target,category) VALUES ('notebook','notebook/index.php','notebook.gif',0,'0','squaregrey.gif',0,'_self','interaction');
ALTER TABLE quiz ADD feedback_type int NOT NULL default 0;
ALTER TABLE quiz_answer ADD destination text NOT NULL;
CREATE TABLE glossary(glossary_id int unsigned NOT NULL auto_increment, name varchar(255) NOT NULL, description text not null, display_order int, PRIMARY KEY  (glossary_id));
ALTER TABLE glossary ADD display_order int;
ALTER TABLE quiz_question ADD level int UNSIGNED NOT NULL default 0;
ALTER TABLE survey_invitation ADD COLUMN session_id SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE quiz_answer   CHANGE ponderation ponderation float(6,2) NOT NULL DEFAULT 0;
ALTER TABLE quiz_question CHANGE ponderation ponderation float(6,2) NOT NULL DEFAULT 0;
ALTER TABLE lp ADD session_id int unsigned not null default 0;
ALTER TABLE document ADD session_id int unsigned not null default 0;