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

| Column  | Type       | Options     |
| ------  | ---------- | ----------- |
| name    | string     | null: false |
| text    | image      | null: false |
| image   | string     | null: false |
| price   | integer    | null: false |
| user_id | integer    | null: false |

### Association

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

