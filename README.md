# テーブル設計

## users テーブル

| Column    | Type    | Options     |
| --------- | ------  | ----------- |
| nickname  | string  | null: false |
| email     | string  | null: false |
| password  | string  | null: false |
| f-name    | string  | null: false |
| l-name    | string  | null: false |
| f-name-h  | string  | null: false |
| l-name-h  | string  | null: false |
| birthday  | date    | null: false |

### Association

- has_many :items
- has_many :comments
- has_one :address

## items テーブル

| Column  | Type       | Options     |
| ------  | ---------- | ----------- |
| name    | string     | null: false |
| text    | string     | null: false |
| image   | string     | null: false |
| price   | integer    | null: false |
| user_id | integer    | null: false |

### Association

- has_many :comments
- belongs_to :user
- has_one :address

## addresses テーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| post_code  | integer    | null: false |
| pref       | string     | null: false |
| block      | string     | null: false |
| building   | string     | null: true  |
| tellphone  | integer    | null: false |
| item_id    | integer    | null: false |
| user_id    | integer    | null: false |

### Association

- belongs_to :item
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
