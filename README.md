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
| last_name_kana  | string  | null: false |
| birthday        | date    | null: false |

### Association

- has_many :items
- has_many :orders
- has_many :comment


## items テーブル

| Column             | Type       | Options           |
| ------------------ | ---------- | ----------------- |
| name               | string     | null: false       |
| comment            | text       | null: false       |
| price              | integer    | null: false       |
| category_id(activ) | integer    | null: false       |
| status_id(activ)   | integer    | null: false       |
| delivery_id(activ) | integer    | null: false       |
| area_id(activ)     | integer    | null: false       |
| day_id(activ)      | integer    | null: false       |
| user_id            | integer    | foreign_key: true |


### Association

- belongs_to :user
- has_one :order
- has_many :comment

## addresses テーブル

| Column               | Type       | Options           |
| -------------------- | ---------- | ----------------- |
| post_code            | string     | null: false       |
| prefecture_id(activ) | integer    | null: false       |
| city                 | string     | null: false       |
| block                | string     | null: false       |
| building             | string     | null: true        |
| tellphone            | string     | null: false       |
| order_id             | integer    | foreign_key: true |

### Association

- belongs_to :order

### orders テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| item_id    | integer    | foreign_key: true |
| user_id    | integer    | foreign_key: true |

### Association

belongs_to :user
belongs_to :item
has_one :address

### comments テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| item_id    | integer    | foreign_key: true |
| user_id    | integer    | foreign_key: true |
| text       | text       | null: fakse       |


### Association

belongs_to :item
belongs_to :user

### likes テーブル

| Column     | Type          | Options           |
| ---------- | ------------- | ----------------- |
| user       | references    | foreign_key: true |
| item       | references    | foreign_key: true |


### Association

belongs_to :user
belongs_to :item