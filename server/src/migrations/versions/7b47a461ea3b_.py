"""empty message

Revision ID: 7b47a461ea3b
Revises: cf79a883dac4
Create Date: 2024-03-31 16:07:48.000232

"""

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = "7b47a461ea3b"
down_revision = "cf79a883dac4"
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table("users", schema=None) as batch_op:
        batch_op.add_column(sa.Column("admin", sa.Boolean(), server_default="0", nullable=False))
        batch_op.add_column(sa.Column("member", sa.Boolean(), server_default="0", nullable=False))
        batch_op.drop_column("color_scheme")

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table("users", schema=None) as batch_op:
        batch_op.add_column(sa.Column("color_scheme", sa.VARCHAR(), autoincrement=False, nullable=False))
        batch_op.drop_column("member")
        batch_op.drop_column("admin")

    # ### end Alembic commands ###
