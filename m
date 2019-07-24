Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255357404E
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jul 2019 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfGXUoK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 16:44:10 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:60087 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGXUoJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 16:44:09 -0400
Received: from cpe-2606-a000-111b-6140-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:6140::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hqO7D-0005Wf-6R; Wed, 24 Jul 2019 16:44:01 -0400
Date:   Wed, 24 Jul 2019 16:43:32 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/4] sctp: check addr_size with sa_family_t size
 in __sctp_setsockopt_connectx
Message-ID: <20190724204332.GF7212@hmswarspite.think-freely.org>
References: <cover.1563817029.git.lucien.xin@gmail.com>
 <c875aa0a5b2965636dc3da83398856627310b280.1563817029.git.lucien.xin@gmail.com>
 <20190723152449.GB8419@localhost.localdomain>
 <CADvbK_eiS26aMZcPrj2oNvZh_42phWiY71M7=UNvjEeB-B9bDQ@mail.gmail.com>
 <20190724112235.GA7212@hmswarspite.think-freely.org>
 <20190724123650.GD6204@localhost.localdomain>
 <20190724124907.GA8640@localhost.localdomain>
 <20190724184456.GC7212@hmswarspite.think-freely.org>
 <20190724190543.GH6204@localhost.localdomain>
 <20190724191243.GA4063@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724191243.GA4063@localhost.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 24, 2019 at 04:12:43PM -0300, Marcelo Ricardo Leitner wrote:
> On Wed, Jul 24, 2019 at 04:05:43PM -0300, Marcelo Ricardo Leitner wrote:
> > On Wed, Jul 24, 2019 at 02:44:56PM -0400, Neil Horman wrote:
> > > On Wed, Jul 24, 2019 at 09:49:07AM -0300, Marcelo Ricardo Leitner wrote:
> > > > On Wed, Jul 24, 2019 at 09:36:50AM -0300, Marcelo Ricardo Leitner wrote:
> > > > > On Wed, Jul 24, 2019 at 07:22:35AM -0400, Neil Horman wrote:
> > > > > > On Wed, Jul 24, 2019 at 03:21:12PM +0800, Xin Long wrote:
> > > > > > > On Tue, Jul 23, 2019 at 11:25 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 23, 2019 at 01:37:57AM +0800, Xin Long wrote:
> > > > > > > > > Now __sctp_connect() is called by __sctp_setsockopt_connectx() and
> > > > > > > > > sctp_inet_connect(), the latter has done addr_size check with size
> > > > > > > > > of sa_family_t.
> > > > > > > > >
> > > > > > > > > In the next patch to clean up __sctp_connect(), we will remove
> > > > > > > > > addr_size check with size of sa_family_t from __sctp_connect()
> > > > > > > > > for the 1st address.
> > > > > > > > >
> > > > > > > > > So before doing that, __sctp_setsockopt_connectx() should do
> > > > > > > > > this check first, as sctp_inet_connect() does.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > > > > > > > ---
> > > > > > > > >  net/sctp/socket.c | 2 +-
> > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > > > > > > > index aa80cda..5f92e4a 100644
> > > > > > > > > --- a/net/sctp/socket.c
> > > > > > > > > +++ b/net/sctp/socket.c
> > > > > > > > > @@ -1311,7 +1311,7 @@ static int __sctp_setsockopt_connectx(struct sock *sk,
> > > > > > > > >       pr_debug("%s: sk:%p addrs:%p addrs_size:%d\n",
> > > > > > > > >                __func__, sk, addrs, addrs_size);
> > > > > > > > >
> > > > > > > > > -     if (unlikely(addrs_size <= 0))
> > > > > > > > > +     if (unlikely(addrs_size < sizeof(sa_family_t)))
> > > > > > > > I don't think this is what you want to check for here.  sa_family_t is
> > > > > > > > an unsigned short, and addrs_size is the number of bytes in the addrs
> > > > > > > > array.  The addrs array should be at least the size of one struct
> > > > > > > > sockaddr (16 bytes iirc), and, if larger, should be a multiple of
> > > > > > > > sizeof(struct sockaddr)
> > > > > > > sizeof(struct sockaddr) is not the right value to check either.
> > > > > > > 
> > > > > > > The proper check will be done later in __sctp_connect():
> > > > > > > 
> > > > > > >         af = sctp_get_af_specific(daddr->sa.sa_family);
> > > > > > >         if (!af || af->sockaddr_len > addrs_size)
> > > > > > >                 return -EINVAL;
> > > > > > > 
> > > > > > > So the check 'addrs_size < sizeof(sa_family_t)' in this patch is
> > > > > > > just to make sure daddr->sa.sa_family is accessible. the same
> > > > > > > check is also done in sctp_inet_connect().
> > > > > > > 
> > > > > > That doesn't make much sense, if the proper check is done in __sctp_connect with
> > > > > > the size of the families sockaddr_len, then we don't need this check at all, we
> > > > > > can just let memdup_user take the fault on copy_to_user and return -EFAULT.  If
> > > > > > we get that from memdup_user, we know its not accessible, and can bail out.
> > > > > > 
> > > > > > About the only thing we need to check for here is that addr_len isn't some
> > > > > > absurdly high value (i.e. a negative value), so that we avoid trying to kmalloc
> > > > > > upwards of 2G in memdup_user.  Your change does that just fine, but its no
> > > > > > better or worse than checking for <=0
> > > > > 
> > > > > One can argue that such check against absurdly high values is random
> > > > > and not effective, as 2G can be somewhat reasonable on 8GB systems but
> > > > > certainly isn't on 512MB ones. On that, kmemdup_user() will also fail
> > > > > gracefully as it uses GFP_USER and __GFP_NOWARN.
> > > > > 
> > > > > The original check is more for protecting for sane usage of the
> > > > > variable, which is an int, and a negative value is questionable. We
> > > > > could cast, yes, but.. was that really the intent of the application?
> > > > > Probably not.
> > > > 
> > > > Though that said, I'm okay with the new check here: a quick sanity
> > > > check that can avoid expensive calls to kmalloc(), while more refined
> > > > check is done later on.
> > > > 
> > > I agree a sanity check makes sense, just to avoid allocating a huge value
> > > (even 2G is absurd on many systems), however, I'm not super comfortable with
> > > checking for the value being less than 16 (sizeof(sa_family_t)).  The zero check
> > 
> > 16 bits you mean then, per
> > include/uapi/linux/socket.h
> > typedef unsigned short __kernel_sa_family_t;
> > include/linux/socket.h
> > typedef __kernel_sa_family_t    sa_family_t;
> > 
> > > is fairly obvious given the signed nature of the lengh field, this check makes
> > > me wonder what exactly we are checking for.
> > 
> > A minimum viable buffer without doing more extensive tests. Beyond
> > sa_family, we need to parse sa_family and then that's left for later.
> > Perhaps a comment helps, something like
> > 	/* Check if we have at least the family type in there */
> > ?
> 
> Hm, then this could be
> -     if (unlikely(addrs_size <= 0))
> +     if (unlikely(addrs_size < sizeof(struct sockaddr_in)))
> (ipv4)
> As it can't be smaller than that, always.
> 
True, but I think perhaps just the family type size check is more correct, as
thats the minimal information we need to get the proper sockaddr_len out of
sctp_get_af_specific.

Neil

> > 
> >   Marcelo
> > 
> > > 
> > > Neil
> > > 
> > > > > 
> > > > > > 
> > > > > > Neil
> > > > > > 
> > > > > > > >
> > > > > > > > Neil
> > > > > > > >
> > > > > > > > >               return -EINVAL;
> > > > > > > > >
> > > > > > > > >       kaddrs = memdup_user(addrs, addrs_size);
> > > > > > > > > --
> > > > > > > > > 2.1.0
> > > > > > > > >
> > > > > > > > >
> > > > > > > 
> > > > 
> > 
> 
