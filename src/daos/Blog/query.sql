SELECT  `Blog`.`id`
       ,`Blog`.`title`
       ,`Blog`.`status`
       ,`Blog`.`path`
       ,`Blog`.`content`
       ,`Blog`.`visible`
       ,`Blog`.`last_publish`
       ,`Blog`.`feature_image`
       ,`Blog`.`description`
       ,`Blog`.`allow_comment`
       ,`Blog`.`stick_to_top`
       ,`Blog`.`view`
       ,`Blog`.`createdAt`
       ,`category`.`id`          AS `category.id`
       ,`category`.`name`        AS `category.name`
       ,`category`.`description` AS `category.description`
       ,`category`.`path`        AS `category.path`
       ,`tag`.`id`               AS `tag.id`
       ,`tag`.`name`             AS `tag.name`
       ,`tag`.`description`      AS `tag.description`
       ,`tag`.`path`             AS `tag.path`
       ,`media`.`id`             AS `media.id`
       ,`media`.`title`          AS `media.title`
       ,`media`.`url`            AS `media.url`
       ,`media`.`filename`       AS `media.filename`
       ,`media`.`filetype`       AS `media.filetype`
       ,`media`.`alt`            AS `media.alt`
FROM `Blogs` AS `Blog`
INNER JOIN
( `Blog_Category` AS `category->Blog_Category`
	INNER JOIN `Categories` AS `category`
	ON `category`.`id` = `category->Blog_Category`.`CategoryId`
)
ON `Blog`.`id` = `category->Blog_Category`.`BlogId` AND (`category`.`id` = ? OR `category`.`path` = ?)
INNER JOIN
( `Blog_Tag` AS `tag->Blog_Tag`
	INNER JOIN `Tags` AS `tag`
	ON `tag`.`id` = `tag->Blog_Tag`.`TagId`
)
ON `Blog`.`id` = `tag->Blog_Tag`.`BlogId` AND (`tag`.`id` = ? OR `tag`.`path` = ?)
LEFT OUTER JOIN `Media` AS `media`
ON `Blog`.`feature_image` = `media`.`filename`
WHERE (`Blog`.`status` = 'publish' AND `Blog`.`title` LIKE '%%')
ORDER BY `Blog`.`last_publish` DESC;