# テーブル設計

## users テーブル

| Column          | Type    | Options     |
| --------------- | ------  | ----------- |
| nickname        | string  | null: false |
| email           | string  | null: false |
| password        | string  | null: false |
| first_name      | string  | null: false |
| last_name       | string  | null: false |
| first_name_kana | string  | null: false |
| last_name-kana  | string  | null: false |
| birthday        | date    | null: false |

### Association

- has_many :items
- has_one :address

## items テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| name          | string     | null: false |
| text          | image      | null: false |
| price         | integer    | null: false |
| category_id   | integer    | null: false |
| status_id     | integer    | null: false |
| delivery_id   | integer    | null: false |
| area_id       | integer    | null: false |
| day_id        | integer    | null: false |
| user_id       | integer    | null: false |


### Association

- belongs_to :user
- has_one :address

## addresses テーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| post_code  | string     | null: false |
| pref       | string     | null: false |
| block      | string     | null: false |
| building   | string     | null: true  |
| tellphone  | string     | null: false |
| item_id    | integer    | null: false |
| user_id    | integer    | null: false |

### Association

- belongs_to :item
- belongs_to :user

### order テーブル

| Column     | Type       | Options     |
| item_id    | integer    | null: false |
| user_id    | integer    | null: false |

### Association

has_one :user
has_one :item