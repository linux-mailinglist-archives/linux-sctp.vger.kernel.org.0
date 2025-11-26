Return-Path: <linux-sctp+bounces-748-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A8DC88AA1
	for <lists+linux-sctp@lfdr.de>; Wed, 26 Nov 2025 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F133B4FE4
	for <lists+linux-sctp@lfdr.de>; Wed, 26 Nov 2025 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390593164AD;
	Wed, 26 Nov 2025 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8ykWSB/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58F313542
	for <linux-sctp@vger.kernel.org>; Wed, 26 Nov 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146080; cv=none; b=dhsfoK6sW1johGNeWBI2PxwXpnsl2XCenaeWx9uN+n4rA9YE+qodIhtZUIHtdHCZ1+1F+QJZDuDY7KGDmIZhE39G29iSVJO80AYMKVdRrTkXO9NFemoyWrB7BHPFZpVR91iv9s6CMPoUKBiURXosP+jfM+77v9hraJAYa9FoBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146080; c=relaxed/simple;
	bh=PvUIJvSgMdPOtL9W8rtLNpPwhlZeahTZTO8EKu6PnoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZvxP193x2dh1aXMxKxhiMKc8x3dchNN54dTK+OkxkhV6UnCQDEL78OAD0UQM5NzQWdQPX1aIJXQn1S7PgCLId37qVwDrKwcWYzNDXwo7FBAXaJdg7ExbordnVFdfFcEPFkZohLe2nhvX0G8KmqLHHXv6it+V96vdgWf7BmGuyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8ykWSB/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso42205455e9.2
        for <linux-sctp@vger.kernel.org>; Wed, 26 Nov 2025 00:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764146076; x=1764750876; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXYtZ24dEe4pYQc6SEgeXi/+vsS3K8tFfHn3ZfaclBM=;
        b=L8ykWSB/gWHDy7jc+PrY9K6S8gQ/e9n4m2Cte5nUFNFT0u9aAEEuOa/GZm5lRV7zXF
         0HnlGFQT930m3dU9U1hGHTEF0qbaWFEWzeTcDZFzL/KvGaCm5WccsgdUvgfKnY/oTK63
         NoNjwhXaRq6WfoUYEdSKVY5ymKtYbpFOxzTZewgPF5sYwnE4Q3sagFLUX0D/VHvtj1pW
         bRZ37tPbcnqbiP5i9YQZPZw1TRpSnGOySSaa/nolQKitlC5delplYQqKbqm/Mh8DZm5U
         n9/H06QqzMTo9uZ6Tl22tvurS0gzqbeYf5cCrTuEIZGyxjifOQkxy12ooCT/+YoIoMBZ
         ULgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146076; x=1764750876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXYtZ24dEe4pYQc6SEgeXi/+vsS3K8tFfHn3ZfaclBM=;
        b=M1OeTAQ43cca/Iq5dihCLyYlY45Qze/q1QalpOd8yWI/CSEUvJfHqhSDZJmK6dEFdx
         fP0oygfmsWOjzaxzqaDZ3LS67eX8QT2IGk2C0q/MZuisWwWqed2+lbPnfVPvQdYXw7fW
         EiVF2uNUqlYVPQ+hq0FGzpjqpoNX0U6LMoWpZJzbSiaRPIef9mRyq4AgudMpBpI8ByLW
         FxCQHtlh519Pg/JWrAZUj3B+ryAIxluCQNFEHq//A/8qO37MD5JCkznVJevhKkqhIQ71
         n90956Zoqo+oUS/0FH0bZAC7uV7Ul5qTZ9c6RigsCdrUhQ4fW03tnTN1DLUnmnFDWRuo
         BQLg==
X-Gm-Message-State: AOJu0Yx1xBpgXZS5Rl3IdA2K1TvskA2T98L1EeRr7iZQpo8Uu1vR++wx
	thBEQo/5wW0IDlkES0LMpZWrIMs4TJVg8YPDuweI8MuYWgncrf3AQJZbHXSv5apjA00=
X-Gm-Gg: ASbGnctBsmEZXFfwhPwntoe2O8cCcI8rQFU94iL/Z9JXgEvo1/P7CMYpmeftzbukmlX
	OjzVgO9gGNdKSQZA1W5/QLGmviWZ5u3IiLNPreREka5UBmpjWGwcKyPoPJCewnFmqXiUThWpb0s
	OEb2kwMFtjfjnYF9SwZrdlsA9RZ+3/fQyzTYng6LBgvOCvK1K1QtI1p1/6lwXDCcxE9l1D3xsBk
	O95sjE22b3/hUsG2fojQw+94YdXPWpQ9RQQzrDQ9V2aDaWsKVAEcrTf23P3BFO5BHzyfJODYKxI
	G61VWmew74joAs1rv08FZPKHW9ZbT2L1sigErOU1YHQqE5RAiqwH3SvGSOxeLWTrbPqXZcnFge1
	Ckkc3SdiHhp4pgrzk8aoVfzfqbOk036h+gryTbsLuZaO4tDKM6/ywZyOwNvM77ReRkRKsOcHeuP
	dHvL9xFY/bswKW89fZ3Kf3J7qaJw==
X-Google-Smtp-Source: AGHT+IEXMnOjmgYAtAR0yBN5uekvG7782bIRKI/MdtxVAPWNeJQqVu53fbTtnitKymyvAkHfqAmC8w==
X-Received: by 2002:a05:600c:1994:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477c016e402mr165463215e9.10.1764146076373;
        Wed, 26 Nov 2025 00:34:36 -0800 (PST)
Received: from localhost ([41.210.159.101])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47903e65d51sm38474565e9.0.2025.11.26.00.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:34:35 -0800 (PST)
Date: Wed, 26 Nov 2025 11:34:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-sctp@vger.kernel.org
Subject: [bug report] net/sctp: convert sctp_getsockopt_peeloff_common() to
 FD_PREPARE()
Message-ID: <aSa7l8aK1cHv1GEI@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Christian Brauner,

Commit 859ceac73090 ("net/sctp: convert
sctp_getsockopt_peeloff_common() to FD_PREPARE()") from Nov 23, 2025
(linux-next), leads to the following Smatch static checker warning:

	net/sctp/socket.c:5733 sctp_getsockopt_peeloff_common()
	warn: 'newsock' was already freed. (line 5731)

net/sctp/socket.c
    5719 static int sctp_getsockopt_peeloff_common(struct sock *sk,
    5720                                           sctp_peeloff_arg_t *peeloff, int len,
    5721                                           char __user *optval,
    5722                                           int __user *optlen, unsigned flags)
    5723 {
    5724         struct socket *newsock;
    5725         int retval;
    5726 
    5727         retval = sctp_do_peeloff(sk, peeloff->associd, &newsock);
    5728         if (retval < 0)
    5729                 return retval;
    5730 
    5731         FD_PREPARE(fdf, flags & SOCK_CLOEXEC, sock_alloc_file(newsock, 0, NULL));
                                                                       ^^^^^^^
sock_alloc_file() calls sock_release() on error.

    5732         if (fdf.err) {
--> 5733                 sock_release(newsock);
                         ^^^^^^^^^^^^^^^^^^^^^
double free.

    5734                 return fdf.err;
    5735         }
    5736 
    5737         pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
    5738                  fd_prepare_fd(fdf));
    5739 
    5740         if (flags & SOCK_NONBLOCK)
    5741                 fd_prepare_file(fdf)->f_flags |= O_NONBLOCK;
    5742 
    5743         /* Return the fd mapped to the new socket.  */
    5744         if (put_user(len, optlen))
    5745                 return -EFAULT;
    5746 
    5747         peeloff->sd = fd_prepare_fd(fdf);
    5748         if (copy_to_user(optval, peeloff, len))
    5749                 return -EFAULT;
    5750 
    5751         return fd_publish(fdf);
    5752 }

regards,
dan carpenter

