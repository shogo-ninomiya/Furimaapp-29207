# テーブル設計

## users テーブル

| Column   | Type    | Options     |
| -------- | ------  | ----------- |
| nickname | string  | null: false |
| email    | string  | null: false |
| password | string  | null: false |
| name-hr  | string  | null: false |
| name-kt  | string  | null: false |
| name-kan | string  | null: false |
| birthday | date    | null: false |

### Association

- has_many :items
- has_many :comments

## items テーブル

| Column  | Type       | Options     |
| ------  | ---------- | ----------- |
| text    | string     | null: false |
| image   | string     | null: false |
| user_id | integer    | null: false |

### Association

- has_many :comments
- belongs_to :user

## comments テーブル

| Column  | Type       | Options     |
| ------  | ---------- | ----------- |
| text    | string     | null: false |
| item_id | integer    | null: false |
| user_id | integer    | null: false |

### Association

- belongs_to :item
- belongs_to :user
