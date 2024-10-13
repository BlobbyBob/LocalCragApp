"""empty message

Revision ID: a5fadc00eef7
Revises: 874b28df20ae
Create Date: 2024-03-14 14:36:59.961858

"""

import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = "a5fadc00eef7"
down_revision = "874b28df20ae"
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table("lines", schema=None) as batch_op:
        batch_op.add_column(sa.Column("child_friendly", sa.Boolean(), nullable=False, server_default="false"))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table("lines", schema=None) as batch_op:
        batch_op.drop_column("child_friendly")

    # ### end Alembic commands ###
